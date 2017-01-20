import org.fluentlenium.adapter.junit.After;
import org.fluentlenium.adapter.junit.FluentTest;
import org.fluentlenium.core.hook.wait.Wait;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.logging.Level;

import static org.assertj.core.api.Assertions.assertThat;

@Wait
public class SmokeTest extends FluentTest {

    @Override
    public WebDriver newWebDriver() {
//        DesiredCapabilities capabilities = DesiredCapabilities.chrome();
//        LoggingPreferences logPrefs = new LoggingPreferences();
//        logPrefs.enable(LogType.BROWSER, Level.ALL);
//        capabilities.setCapability(CapabilityType.LOGGING_PREFS, logPrefs);
//        capabilities.setJavascriptEnabled(true);

        System.setProperty("webdriver.chrome.logfile", "chromedriver.log");
        return new ChromeDriver();
    }

    @Test
    public void smokeTest() throws MalformedURLException {
        goTo("https://www.google.com");
        assertThat($("#hplogo")).isNotNull();
    }
}
