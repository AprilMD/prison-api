package net.syscon.elite.service.impl;

import lombok.val;
import net.syscon.elite.api.model.Adjudication;
import net.syscon.elite.api.model.AdjudicationOffence;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.api.support.PageRequest;
import net.syscon.elite.repository.AdjudicationsRepository;
import net.syscon.elite.service.AdjudicationSearchCriteria;
import net.syscon.elite.service.AdjudicationService;
import net.syscon.elite.service.BookingService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class AdjudicationServiceImplTest {

    @Mock private AdjudicationsRepository adjudicationsRepository;
    @Mock private BookingService bookingService;
    private AdjudicationService adjudicationService;

    @Before
    public void setup() {
        adjudicationService = new AdjudicationServiceImpl(adjudicationsRepository, bookingService);
    }

    @Test
    public void findAdjudications() {

        val adjudication = Adjudication.builder().build();
        val expectedResult = new Page<>(List.of(adjudication), 1, new PageRequest());
        val criteria = AdjudicationSearchCriteria.builder().offenderNumber("OFF-1").build();

        when(adjudicationsRepository.findAdjudications(criteria)).thenReturn(expectedResult);

        assertThat(adjudicationService.findAdjudications(criteria)).isEqualTo(expectedResult);

        verify(bookingService).verifyCanViewLatestBooking(criteria.getOffenderNumber());
    }

    @Test
    public void adjudicationOffences() {

        val expectedResult = List.of(AdjudicationOffence.builder().build());

        when(adjudicationsRepository.findAdjudicationOffences("OFF-1")).thenReturn(expectedResult);

        assertThat(adjudicationService.findAdjudicationsOffences("OFF-1")).isEqualTo(expectedResult);
    }
}