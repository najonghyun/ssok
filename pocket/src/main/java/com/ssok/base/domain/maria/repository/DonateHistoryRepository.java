package com.ssok.base.domain.maria.repository;

import com.ssok.base.domain.maria.entity.DonateHistory;
import com.ssok.base.domain.maria.entity.PocketHistory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DonateHistoryRepository extends JpaRepository<DonateHistory, Long> {
}
