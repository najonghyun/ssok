package com.ssok.member.domain.api.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class MemberMydataAccessTokenUpdateRequest {
    private Long memberSeq;
    private String memberMydataAccessToken;
}
