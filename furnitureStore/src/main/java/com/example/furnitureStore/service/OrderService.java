package com.example.furnitureStore.service;

import com.example.furnitureStore.config.email.EmailSender;
import com.example.furnitureStore.dto.OrderDto;
import com.example.furnitureStore.entity.*;
import com.example.furnitureStore.repository.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.File;
import java.time.LocalDateTime;
import java.util.*;
import java.util.regex.Pattern;

@Service
@Transactional
@RequiredArgsConstructor
public class OrderService {

    private final OrderHistoryRepository orderHistoryRepository;
    private final UserRepository userRepository;
    private final StatusRepository statusRepository;
    private final PaymentMethodRepository paymentMethodRepository;
    private final AddressTypeRepository addressTypeRepository;
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final EmailSender emailSender;
    private final TransportDetailRepository transportDetailRepository;
    private final BillingDetailRepository billingDetailRepository;

    //kesz:
    public ResponseEntity<Object> getOrderHistoryByUserId(Integer userId) {
        try {
            if (userId == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(userId).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok().body(searchedUser.getOrderHistoryList());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> cancelOrder(Integer orderId, Integer cancelerUserId) {
        try {
            if (orderId == null) {
                return ResponseEntity.status(422).build();
            }
            OrderHistory searchedOrderHistory = orderHistoryRepository.findById(orderId).orElse(null);
            if (searchedOrderHistory == null || searchedOrderHistory.getIsCanceled()) {
                return ResponseEntity.status(404).body("orderNotFound");
            }
            if (cancelerUserId != 0) {
                User cancelerUser = userRepository.getUserById(cancelerUserId).orElse(null);
                if (cancelerUser == null || cancelerUser.getIsDeleted()) {
                    return ResponseEntity.status(404).body("userNotFound");
                }
                searchedOrderHistory.setCancelerUser(cancelerUser);
            }

            try {
                emailSender.sendEmailAboutCancelledOrder(searchedOrderHistory.getEmail());
            } catch (Exception e) {
                return ResponseEntity.internalServerError().body("emailSenderError");
            }

            searchedOrderHistory.setStatus(statusRepository.findById(3).get());
            searchedOrderHistory.setCanceledAt(LocalDateTime.now());
            searchedOrderHistory.setIsCanceled(true);
            return ResponseEntity.ok().body(orderHistoryRepository.save(searchedOrderHistory));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }


    //kesz
    public ResponseEntity<Object> getAllOrder() {
        try {
            return ResponseEntity.ok().body(orderHistoryRepository.findAll());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz:
    public ResponseEntity<Object> sendOrder(OrderDto newOrder, Integer basketId) {
        try {
            if (newOrder == null || basketId == null) {
                return ResponseEntity.status(422).build();
            }

            if (newOrder.userId() != null) {
                User searchedUser = userRepository.getUserById(newOrder.userId()).orElse(null);
                if (searchedUser == null || searchedUser.getIsDeleted()) {
                    return ResponseEntity.status(404).body("userNotFound");
                }
            }

            PaymentMethod searchedPaymentMethod = paymentMethodRepository.findById(newOrder.paymentId()).orElse(null);
            Cart searchedCart = cartRepository.findById(basketId).orElse(null);

            if (searchedPaymentMethod == null) {
                return ResponseEntity.status(404).body("paymentMethodNotFound");
            } else if (searchedCart == null) {
                return ResponseEntity.status(404).body("basketNotFound");
            }

            if (!isEmailValid(newOrder.email().trim())) {
                return ResponseEntity.status(415).body("invalidEmail");
            }

            int sumPrice = 0;
            List<OrderProduct> orderedProductList = new ArrayList<>();
            for (int i = 0; i < searchedCart.getCartProductList().size(); i++) {
                CartProduct productFromBasket = searchedCart.getCartProductList().get(i);
                Product product = productFromBasket.getCartProduct();
                product.setAmount(product.getAmount() - productFromBasket.getAmount());

                orderedProductList.add(new OrderProduct(productFromBasket.getAmount(), product));
                productRepository.save(product);
                sumPrice += (product.getPrice() * productFromBasket.getAmount());
            }

            try {
                emailSender.sendEmailAboutOrderWithVCode(newOrder.email(), generateVCode());
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.internalServerError().body("emailSenderError");
            }

            System.out.println(sumPrice);

            TransportDetail transportDetail = transportDetailRepository.save(new TransportDetail(newOrder.tPostCode(), newOrder.tTown(), newOrder.tAddress(), newOrder.tHouseNumber(), newOrder.tOther(), addressTypeRepository.findById(newOrder.tAddressType()).get()));
            BillingDetail billingDetail = billingDetailRepository.save(new BillingDetail(newOrder.bPostCode(), newOrder.bTown(), newOrder.bAddress(), newOrder.bHouseNumber(), newOrder.companyName(), newOrder.taxNumber(), newOrder.bOther(), addressTypeRepository.findById(newOrder.bAddressType()).get()));
            orderHistoryRepository.save(new OrderHistory(newOrder.firstName(), newOrder.lastName(), newOrder.phone(), newOrder.email(), userRepository.getUserById(newOrder.userId()).get(), billingDetail, transportDetail, searchedPaymentMethod, statusRepository.findById(1).get(), orderedProductList));

            cartRepository.clearCart(basketId);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }


    //Validatorok:
    //kesz:
    public Boolean isBillingDetailValid(BillingDetail billingDetail) {
        if (billingDetail.getId() != null) {
            return false;
        }
        AddressType searchedAddressType = addressTypeRepository.findById(billingDetail.getBillingAddressType().getId()).orElse(null);
        if (searchedAddressType == null) {
            return false;
        } else if (!isValidAddress(billingDetail.getPostCode(), billingDetail.getTown())) {
            return false;
        }
        if (billingDetail.getTaxNumber() != null) {
            if (!isValidTaxNumber(billingDetail.getTaxNumber() + "")) {
                return false;
            }
        }

        return true;
    }

    //kesz:
    public Boolean isTransportDetailValid(TransportDetail transportDetail) {
        if (transportDetail.getId() != null) {
            return false;
        }
        AddressType searchedAddressType = addressTypeRepository.findById(transportDetail.getTransportAddressType().getId()).orElse(null);
        if (searchedAddressType == null) {
            return false;
        } else if (!isValidAddress(transportDetail.getPostCode(), transportDetail.getTown())) {
            return false;
        }
        return true;
    }

    //kesz:
    public Boolean isValidAddress(Integer postCode, String town) {
        ArrayList<List<String>> townList = new ArrayList<>();

        try {
            File txt = new File("src/main/java/com/example/bookStore/service/telepulesek.txt");
            Scanner reader = new Scanner(txt);

            while (reader.hasNextLine()) {
                townList.add(Arrays.stream(reader.nextLine().split("\t")).toList().subList(0, 2));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        for (List<String> i : townList) {
            if (i.get(0).equals(postCode.toString()) && i.get(1).toLowerCase().equals(town.toLowerCase())) {
                return true;
            }
        }

        return false;
    }

    //kesz:
    public Boolean isValidTaxNumber(String taxNumber) {
        ArrayList<String> taxNumbersOfArea = new ArrayList<>(Arrays.asList("02", "22", "03", "23", "04", "24", "05", "25", "06", "26", "07", "27", "08", "28", "09", "29", "10", "30", "11", "31", "12", "32", "13", "33", "14", "34", "15", "35", "16", "36", "17", "37", "18", "38", "19", "39", "20", "40", "41", "42", "43", "44", "51"));
        ArrayList<String> typeOfTaxes = new ArrayList<>(Arrays.asList("1", "2", "3", "4", "5"));

        if (taxNumber.length() != 11) {
            return false;
        } else if (!typeOfTaxes.contains(String.valueOf(taxNumber.charAt(10)))) {
            return false;
        } else if (!taxNumbersOfArea.contains(taxNumber.substring(11))) {
            return false;
        }
        return true;
    }

    //kesz:
    public Boolean isEmailValid(String email) {
        Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
        if (email == null || email.length() > 100) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    //kesz:
    public Boolean isPhoneValid(String phoneNumber) {
        ArrayList<String> phoneServiceCodes = new ArrayList<String>(Arrays.asList("30", "20", "70", "50", "31"));
        return phoneServiceCodes.contains(phoneNumber.substring(0, 2)) && phoneNumber.length() == 9;
    }

    //kesz:
    public String generateVCode() {
        String characters = "!@#$%&*()-+={}[]|\\/:;'\"<>,.?~" + "ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÜŰÚÖÓŐÍ" + "0123456789" + "abcdefghijklmnopqrstuvxyzéáíúöőüű";
        String vCode = "";
        while (vCode.length() != 10) {
            vCode += String.valueOf(characters.charAt(new Random().nextInt(0, characters.length())));
        }

        return vCode;
    }
}
