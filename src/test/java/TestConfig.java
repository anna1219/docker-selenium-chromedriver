import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

public class TestConfig {

    private static String isRemote = System.getenv().get("REMOTE_WEBDRIVER");
    private static RemoteWebDriver webDriver;

    public static WebDriver getDriver() {
        DesiredCapabilities caps = DesiredCapabilities.chrome();
        LoggingPreferences logPrefs = new LoggingPreferences();
        logPrefs.enable(LogType.BROWSER, Level.ALL);
        caps.setCapability(CapabilityType.LOGGING_PREFS, logPrefs);
        caps.setJavascriptEnabled(true);

        System.setProperty("webdriver.chrome.logfile", "chromedriver.log");

        webDriver = new ChromeDriver(caps);

        webDriver.manage().timeouts().pageLoadTimeout(120, TimeUnit.SECONDS);
        webDriver.manage().timeouts().setScriptTimeout(120, TimeUnit.SECONDS);

        return webDriver;
    }
}

