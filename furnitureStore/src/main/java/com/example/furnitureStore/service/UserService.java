package com.example.furnitureStore.service;

import com.example.furnitureStore.config.email.EmailSender;
import com.example.furnitureStore.entity.Cart;
import com.example.furnitureStore.entity.User;
import com.example.furnitureStore.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Date;
import java.util.Random;
import java.util.regex.Pattern;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailSender emailSender;

    //kesz
    public ResponseEntity<Object> login(String username, String password) {
        try {
            if (username == null || password == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserByUsername(username).orElse(null);
            if (searchedUser == null) {
                return ResponseEntity.notFound().build();
            } else {
                if (!passwordEncoder.matches(password, searchedUser.getPassword())) {
                    return ResponseEntity.notFound().build();
                } else {
                    userRepository.save(searchedUser);
                    return ResponseEntity.ok().build();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> register(User newUser) {
        try {
            if (newUser == null) {
                return ResponseEntity.status(422).build();
            }

            if (newUser.getId() != null){
                return ResponseEntity.status(415).body("invalidObject");
            } else if (!isEmailValid(newUser.getEmail())) {
                return ResponseEntity.status(415).body("invalidEmail");
            } else if (!isPasswordValid(newUser.getPassword())) {
                return ResponseEntity.status(415).body("invalidPassword");
            } else {
                newUser.setPassword(passwordEncoder.encode(newUser.getPassword()));
                newUser.setCart(new Cart());
                userRepository.save(newUser);

//                try {
//                    emailSender.sendEmailAboutRegistration(newUser.getEmail());
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    return ResponseEntity.internalServerError().build();
//                }

                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> update(Integer id, String username, String email) {
        try {
            if (id == null || username == null || email == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(id).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }
            if (!isEmailValid(email)){
                return ResponseEntity.status(415).body("invalidEmail");
            } else {
                searchedUser.setUsername(username.trim());
                searchedUser.setEmail(email.trim());
                return ResponseEntity.ok().body(userRepository.save(searchedUser));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> delete(Integer id) {
        try {
            if (id == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(id).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                userRepository.deleteUserById(id);
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> changePfp(MultipartFile newPfpImage, Integer id) {
        try {
            if (id == null || newPfpImage == null) {
                return ResponseEntity.status(422).build();
            }

            User searchedUser = userRepository.getUserById(id).orElse(null);

            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
//                String filePath = "C:\\Users\\bzhal\\Documents\\GitHub\\appointment_management_system\\pmsWebPage\\src\\assets\\images\\pfp" + File.separator + pfpFile.getOriginalFilename();

                try {
//                    FileOutputStream fout = new FileOutputStream(newPfpImage);
//                    fout.write(newPfpImage.getBytes());
//                    fout.close();

                    searchedUser.setPfpPath("assets\\images\\pfp" + File.separator + newPfpImage.getOriginalFilename());
                } catch (Exception e) {
                    return ResponseEntity.internalServerError().body("fileUploadError");
                }

                return ResponseEntity.ok().body(userRepository.save(searchedUser));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> getVerificationCode(String email) {
        try {
            if (email == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserByEmail(email).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                String vCode = generateVCode();
//                try {
//                    emailSender.sendVCodeForPasswordReset(email, vCode);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    return ResponseEntity.internalServerError().build();
//                }
//
//                searchedUser.setVCode(passwordEncoder.encode(vCode));
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("serverError");
        }
    }

    //kesz
    public ResponseEntity<Object> checkVerificationCode(String vCode, String email) {
        try {
            if (vCode == null || email == null) {
                return ResponseEntity.status(422).build();
            }
            if (!isEmailValid(email)) {
                return ResponseEntity.status(415).body("invalidEmail");
            }

            User searchedUser = userRepository.getUserByEmail(email).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.internalServerError().build();
            } else {
//                return ResponseEntity.ok().body(passwordEncoder.matches(vCode, searchedUser.getVCode()));
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> changePassword(String email, String newPassword) {
        try {
            if (email == null || newPassword == null) {
                return ResponseEntity.status(422).build();
            }
            if (!isEmailValid(email)) {
                return ResponseEntity.status(415).body("invalidEmail");
            }

            User searchedUser = userRepository.getUserByEmail(email).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.internalServerError().build();
            }

            if (!isPasswordValid(newPassword)) {
                return ResponseEntity.status(415).body("invalidPassword");
            } else {
                searchedUser.setPassword(passwordEncoder.encode(newPassword));
                userRepository.save(searchedUser);
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //Validatorok:
    public Boolean isEmailValid(String email) {
        Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
        if (email == null || email.length() > 100) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    public Boolean isPasswordValid(String password) {
        if (password.length() < 8 || password.length() > 16) {
            return false;
        }

        String specialCharacters = "\"!@#$%^&*()-_=+[]{};:,.?/\"";
        String numbersText = "1234567890";
        boolean specialChecker = false;
        boolean upperCaseChecker = false;
        boolean lowerCaseChecker = false;
        boolean initChecker = false;

        for (int i = 0; i < password.trim().length(); i++) {
            String selectedChar = String.valueOf(password.charAt(i));

            if (numbersText.contains(selectedChar)) {
                initChecker = true;
            } else if (specialCharacters.contains(selectedChar)) {
                specialChecker = true;
            } else if (selectedChar.equals(selectedChar.toUpperCase())) {
                upperCaseChecker = true;
            } else if (selectedChar.equals(selectedChar.toLowerCase())) {
                lowerCaseChecker = true;
            }
        }

        return specialChecker && upperCaseChecker && lowerCaseChecker && initChecker;
    }

    public String generateVCode() {
        String characters = "!@#$%&*()-+={}[]|\\/:;'\"<>,.?~" + "ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÜŰÚÖÓŐÍ" + "0123456789" + "abcdefghijklmnopqrstuvxyzéáíúöőüű";
        String vCode = "";
        while (vCode.length() != 10) {
            vCode += String.valueOf(characters.charAt(new Random().nextInt(0, characters.length())));
        }

        return vCode;
    }
}