
package itmo.sadiva.model.main;

import itmo.sadiva.model.Component;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MyPrisonerPage extends Component {
    @FindBy(className = "selenium_search_input")
    private WebElement searchInput;

    @FindBy(className = "selenium_add_prisoner_button")
    private WebElement addButton;

}
