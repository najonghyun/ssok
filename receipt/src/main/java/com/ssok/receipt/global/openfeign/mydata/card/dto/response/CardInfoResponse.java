package com.ssok.receipt.global.openfeign.mydata.card.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.extern.java.Log;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class CardInfoResponse {

    @JsonProperty("rsp_code")
    private String rspCode;

    @JsonProperty("rsp_msg")
    private String rspMsg;

    @JsonProperty("search_timestamp")
    private Long searchTimestamp;

    @JsonProperty("card_id")
    private Long cardId;

    @JsonProperty("company")
    private String company;

    @JsonProperty("card_num")
    private String cardNum;

    @JsonProperty("card_type")
    private String cardType;

    @JsonProperty("is_trans_payable")
    private Boolean isTransPayable;

    @JsonProperty("is_cash_card")
    private Boolean isCashCard;

    @JsonProperty("linked_bank_code")
    private String linkedBankCode;

    @JsonProperty("card_brand")
    private String cardBrand;

    @JsonProperty("annual_fee")
    private Long annualFee;

    @JsonProperty("issue_date")
    private Date issueDate;

//    @Builder
//    public CardInfoResponse(Boolean isTransPayable, Boolean isCashCard, String linkedBankCode, String cardBrand, Long annualFee, Date issueDate) {
//        this.isTransPayable = isTransPayable;
//        this.isCashCard = isCashCard;
//        this.linkedBankCode = linkedBankCode;
//        this.cardBrand = cardBrand;
//        this.annualFee = annualFee;
//        this.issueDate = issueDate;
//    }


    public CardInfoResponse(Boolean isTransPayable, Boolean isCashCard, String linkedBankCode, String cardBrand, Long annualFee, Long issueDate) {

        this.rspCode = "200";
        this.rspMsg = "성공";
        this.searchTimestamp = new Date().getTime();
        this.isTransPayable = isTransPayable;
        this.isCashCard = isCashCard;
        this.linkedBankCode = linkedBankCode;
        this.cardBrand = cardBrand;
        this.annualFee = annualFee;
        this.issueDate = new Date(issueDate);
    }
}
