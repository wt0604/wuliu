package com.jk.service;

import com.jk.pojo.Member;

import java.util.List;

public interface WtService {
    List<Member> queryMember(Integer page, Integer rows, Member member);
    List<Member> queryMemberAll(Member member);
}
