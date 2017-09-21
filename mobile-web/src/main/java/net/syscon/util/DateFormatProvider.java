package net.syscon.util;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * Date format helper.
 */
public class DateFormatProvider {

    private DateFormatProvider() {}

    /**
     * Convert a {@code java.time.LocalDate} to Date
     * @param localDate date only
     * @return Date with date only information
     */
    public static Date localDateToDate(LocalDate localDate) {
        if (localDate != null) {
            return Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        }
        return null;
    }

    /**
     * Convert a {@code java.time.LocalDateTime} to Date
     * @param localDateTime Date time
     * @return Date with date and time information
     */
    public static Date localDateToDateTime(LocalDateTime localDateTime) {
        if (localDateTime != null) {
            return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
        }
        return null;
    }

    /**
     * Formats date and time represented by provided dateTime object to an ISO-8601 dateTime representation.
     *
     * @param dateTime an instance of {@code java.sql.Timestamp} or {@code java.util.Date}.
     * @return formatted dateTime or {@code null} if provided dateTime object is {@code null}.
     * @throws IllegalArgumentException if provided dateTime object is not of a supported type.
     */
    public static String toISO8601DateTime(Object dateTime) {
        LocalDateTime localDateTime = toISO8601LocalDateTime(dateTime);
        if (localDateTime != null) {
            return DateTimeFormatter.ISO_LOCAL_DATE_TIME.format(localDateTime);
        }
        return null;
    }

    /**
     * Formats date and time represented by provided dateTime object to an ISO-8601 dateTime representation.
     *
     * @param dateTime an instance of {@code java.sql.Timestamp} or {@code java.util.Date}.
     * @return localDateTime or {@code null} if provided dateTime object is {@code null}.
     * @throws IllegalArgumentException if provided dateTime object is not of a supported type.
     */
    public static LocalDateTime toISO8601LocalDateTime(Object dateTime) {
        LocalDateTime localDateTime = null;
        if (dateTime != null) {
            if (dateTime instanceof java.sql.Timestamp) {
                localDateTime = ((java.sql.Timestamp) dateTime).toLocalDateTime();
            } else if (dateTime instanceof java.util.Date) {
                localDateTime = ((java.util.Date) dateTime).toInstant().atOffset(ZoneOffset.UTC).toLocalDateTime();
            } else {
                throw new IllegalArgumentException("Cannot convert [" + dateTime.getClass().getName() + "] to a LocalDateTime.");
            }
        }
        return localDateTime;
    }

    /**
     * Formats date represented by provided date object to an ISO-8601 date representation (i.e. yyyy-MM-dd).
     * By definition, this method ignores timezone information, if any, that might exist in provided date object.
     *
     * @param date an instance of {@code java.sql.Date} or {@code java.util.Date}.
     * @return formatted date or {@code null} if provided date object is {@code null}.
     * @throws IllegalArgumentException if provided date object is not of a supported type.
     */
    public static String toISO8601Date(Object date) {
        LocalDate localDate = toISO8601LocalDate(date);
        if (localDate != null) {
            return DateTimeFormatter.ISO_LOCAL_DATE.format(localDate);
        }
        return null;
    }

    /**
     * Formats date represented by provided date object to an ISO-8601 date representation (i.e. yyyy-MM-dd).
     * By definition, this method ignores timezone information, if any, that might exist in provided date object.
     *
     * @param date an instance of {@code java.sql.Timestamp} or {@code java.util.Date}
     * @return LocalDate or {@code null} if provided date object is {@code null}.
     * @throws IllegalArgumentException if provided date object is not of a supported type.
     */
    public static LocalDate toISO8601LocalDate(Object date) {
        LocalDate localDate = null;
        if (date != null) {
            if (date instanceof java.sql.Date) {
                localDate = ((java.sql.Date) date).toLocalDate();
            } else if (date instanceof java.util.Date) {
                localDate = ((java.util.Date) date).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            } else {
                throw new IllegalArgumentException("Cannot convert [" + date.getClass().getName() + "] to a LocalDate.");
            }
        }
        return localDate;
    }

}
