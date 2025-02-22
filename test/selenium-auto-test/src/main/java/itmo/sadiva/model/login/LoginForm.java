package itmo.sadiva.model.login;

import itmo.sadiva.config.DriverFactory;
import itmo.sadiva.model.Component;
import itmo.sadiva.utils.PropUtils;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class LoginForm extends Component {
    @FindBy(xpath = "/html/body/app-root/app-login/div/mat-card/mat-card-content/form/mat-form-field[1]/div/div[1]/div/input")
    private WebElement loginInput;

    @FindBy(xpath = "/html/body/app-root/app-login/div/mat-card/mat-card-content/form/mat-form-field[2]/div/div[1]/div/input")
    private WebElement passwordInput;

    @FindBy(xpath = "/html/body/app-root/app-login/div/mat-card/mat-card-content/form/button")
    private WebElement signInButton;

    public void setLogin(String login) {
        loginInput.sendKeys(login);
    }

    public void setPassword(String password) {
        passwordInput.sendKeys(password);
    }

    public void clickSignInButton() {
        signInButton.click();
    }

    public void logIn(String login, String password) {
        driver.get(baseUrl + "/login");
        setLogin(login);
        setPassword(password);
        clickSignInButton();
    }
}
