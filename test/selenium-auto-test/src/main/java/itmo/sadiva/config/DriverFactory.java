package itmo.sadiva.config;

import itmo.sadiva.utils.PropUtils;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;


public class DriverFactory {
    private static final DriverType selectedDriverType;
    private static WebDriver webDriver;

    static {
        selectedDriverType = DriverType.valueOf(PropUtils.get("driver"));
    }

    public static WebDriver getDriver() {
        if (webDriver == null) {
            webDriver = selectedDriverType.getWebDriverObject(new DesiredCapabilities());
        }

        return webDriver;
    }
    public static void unloadDriver() {
        webDriver = null;
    }
}
