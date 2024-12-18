package itmo.sadiva.config;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;


public interface DriverSetup {
    WebDriver getWebDriverObject(DesiredCapabilities capabilities);
}