package com.example.furnitureStore.dto;

public record OrderDto(
        String firstName,
        String lastName,
        String phone,
        String email,
        Integer userId,
        Integer paymentId,
        Integer tPostCode,
        String tTown,
        String tAddress,
        Integer tHouseNumber,
        String tOther,
        Integer tAddressType,
        Integer bPostCode,
        String bTown,
        String bAddress,
        Integer bHouseNumber,
        String bOther,
        Integer taxNumber,
        String companyName,
        Integer bAddressType

) {
}
