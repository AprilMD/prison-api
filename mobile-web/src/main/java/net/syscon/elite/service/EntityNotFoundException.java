package net.syscon.elite.service;

import java.util.function.Supplier;

public class EntityNotFoundException extends RuntimeException implements Supplier<EntityNotFoundException> {
    public static final String DEFAULT_MESSAGE_FOR_ID_FORMAT = "Resource with id [%s] not found.";

    public static EntityNotFoundException withId(long id) {
        return withId(String.valueOf(id));
    }

    public static EntityNotFoundException withId(String id) {
        return new EntityNotFoundException(String.format(DEFAULT_MESSAGE_FOR_ID_FORMAT, id));
    }

    public static EntityNotFoundException withMessage(String message) {
        return new EntityNotFoundException(message);
    }

    public EntityNotFoundException(String message) {
        super(message);
    }

    @Override
    public EntityNotFoundException get() {
        return new EntityNotFoundException(getMessage());
    }

    @Override
    public synchronized Throwable fillInStackTrace() {
        return this;
    }
}
