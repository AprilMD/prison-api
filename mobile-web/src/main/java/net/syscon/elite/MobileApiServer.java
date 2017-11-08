package net.syscon.elite;

import net.syscon.elite.core.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.AbstractEnvironment;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.io.File;

@SpringBootApplication
@EnableSwagger2
public class MobileApiServer {

    private static void setUp() throws Exception {
        final File currDir = new File(".");
        final File projectDir = currDir.getAbsolutePath().contains("mobile-web")? currDir: new File("mobile-web");
        final String activeProfile = System.getProperty(AbstractEnvironment.ACTIVE_PROFILES_PROPERTY_NAME);
        if (activeProfile == null //
                && StringUtils.isBlank(System.getenv("SPRING_PROFILES_ACTIVE"))//
                && projectDir.exists()) {
            System.setProperty(AbstractEnvironment.ACTIVE_PROFILES_PROPERTY_NAME, Constants.SPRING_PROFILE_DEVELOPMENT);
        }
    }

    public static void main(final String[] args) throws Exception {
        setUp();

        SpringApplication.run(MobileApiServer.class, args);
    }
}
