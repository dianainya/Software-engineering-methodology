package itmo.sadiva.model;

import itmo.sadiva.config.DriverFactory;
import itmo.sadiva.utils.PropUtils;
import lombok.Data;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

@Data
public class Component {
    protected final WebDriver driver;
    protected final String baseUrl;

    public Component() {
        this.driver = DriverFactory.getDriver();
        this.baseUrl = PropUtils.get("baseUrl");
        PageFactory.initElements(driver, this);
    }
}