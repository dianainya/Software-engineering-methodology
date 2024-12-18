### 1. Тестирование схемы БД



[Исходники](https://github.com/dianainya/Software-engineering-methodology/tree/main/test/sql-scripts)

Пример теста (test1.sql):

```sql

-- Test 1: Проверка уникальности пользователей в platform_user
BEGIN;

INSERT INTO platform_user (username, password, activated)
VALUES ('db_test_user', 'password', true);

DO
$$
    DECLARE
conflict boolean := false;
BEGIN
BEGIN
INSERT INTO platform_user (username, password, activated)
VALUES ('db_test_user', 'password', true);
EXCEPTION
            WHEN unique_violation THEN
                conflict := true;
END;
        IF conflict THEN
            RAISE NOTICE 'Test 1 - Username uniqueness constraint: OK';
ELSE
            RAISE NOTICE 'Test 1 - Username uniqueness constraint: FAILED';
END IF;
END
$$;

DELETE FROM platform_user WHERE username = 'db_test_user';
COMMIT;

```
Скрипт для запуска:

```bash
#!/bin/bash

DIRECTORY="${1:-.}"

find "$DIRECTORY" -type f -name "*.sql" | while read -r file; do
    echo "Executing $file..."
    psql -U s283945 -f "$file"
    if [ $? -ne 0 ]; then
        echo "Error executing $file"
        exit 1
    else
        echo "$file executed successfully."
    fi
done

```

Рузьтаты:

![img.png](resources/res_db.png)

### 2.  Function Testing (Функциональное тестирование)

**Technique Objective:** Обеспечение корректности моделирования бизнес-цикла, сохранение инвариантов, полная и точная реализация требований

**Technique (Описание процесса):**
Использовать для подробностей документы SRS, UC
1. Создать заключенного в системе и залогиниться
2. Пройти основной поток юзкейса InmatePointsManagement 
3. Убедиться, что платформа распределила заключенных согласно рейтингу
   
**Инструменты:** Junit, Mockito, TestContainers

[Исходный код теста REST-котроллера](https://github.com/dianainya/platform-backend/blob/main/src/test/java/test/sadiva/mpi/platformbackend/rest/BarsControllerTest.java)

Фрагмент:
```java
        @Test
        public void whenAddPointsToPrisoner_thenOk() throws Exception {
        //given
        Prisoner prisoner1 = baseUtils.createPrisoner();
        Prisoner prisoner2 = baseUtils.createPrisoner();
        Prisoner prisoner3 = baseUtils.createPrisoner();

        final BarsAddScoreReq req = new BarsAddScoreReq(prisoner1.getId(), 5);

        //when
        mockMvc.perform(MockMvcRequestBuilders.post(BARS_API + ADD_PATH)
                        .content(objectMapper.writeValueAsString(req))
                        .contentType(MediaType.APPLICATION_JSON))
                //then
                .andExpect(status().isNoContent());
        PrisonerRating actualRating1 = getPrisonerRatingById(prisoner1.getId());
        PrisonerRating actualRating2 = getPrisonerRatingById(prisoner2.getId());
        PrisonerRating actualRating3 = getPrisonerRatingById(prisoner3.getId());

        assertEquals(new BigDecimal(105), actualRating1.getScore());
        assertEquals(new BigDecimal(100), actualRating2.getScore());
        assertEquals(new BigDecimal(100), actualRating3.getScore());
    }
```
[Исходный код для UC](https://github.com/dianainya/platform-backend/blob/main/src/test/java/test/sadiva/mpi/platformbackend/e2e/InmatePointsManagementTest.java)

Фрагмент:
```java
    @Test
    public void whenAnalystSubmitsActionForm_thenPrisonerRatingIsUpdated_andAdminCanView() throws Exception {
        // Получение списка нарушений
        final List<ViolationRes> violations = callGetEndpoint(BARS_API + VIOLATIONS_PATH, new TypeReference<>() {
        });

        assertNotNull(violations, "Список нарушений не должен быть пустым");
        assertNotNull(violations.get(0).code(), "Код нарушения должен быть задан");
        assertNotNull(violations.get(0).score(), "Очки нарушения должны быть заданы");

        final ViolationRes violation = violations.get(0);
        final Prisoner prisoner = baseUtils.createPrisoner();

        // Аналитик отправляет форму с нарушением
        BarsSubtractScoreReq violationRequest = new BarsSubtractScoreReq(prisoner.getId(), violation.code());
        callPostEndpoint204(violationRequest, BARS_API + SUBTRACT_PATH);

        // Проверка обновленного рейтинга заключенного
        final PrisonerRes actualPrisoner = callGetEndpoint( PRISONERS_API + "/" + prisoner.getId(), new TypeReference<>() {
        });
        final BigDecimal expectedRating = new BigDecimal(100 - violation.score());

        assertNotNull(actualPrisoner, "Заключенный должен быть доступен.");
        assertEquals(actualPrisoner.rating(), expectedRating);
    }
```
Результаты:
![img.png](resources/res_intr.png)

### Load Testing (Нагрузочное тестирование) и Stress Testing (Стресс тестирование)

Конфигурация

![img.png](img.png)


### UI тестирование
Technique Objective: Проверка корректного отображения интерфейса регистрации и работы логики выбора блюда, обеспечение соответствия требованиям UX/UI и корректности бизнес-логики.

Technique (Описание процесса):

Использовать для подробностей макеты UX/UI и требования функциональных спецификаций (SRS).
Взаимодействовать с формой регистрации через автоматизированные UI-тесты.
Использовать мок-данные для имитации выборки данных о блюдах.
Шаги выполнения:

Запустить экран регистрации через тестовый фреймворк Compose UI.
Проверить отображение всех обязательных полей на форме.
Заполнить обязательные поля (Фамилия, Имя, Отчество, Паспорт, Дата рождения, Рост, Вес).
Подтвердить корректную активацию кнопки "Подтвердить регистрацию" при валидных данных.
Используя мок-контроллер, подставить тестовые данные о блюде и выбрать его через интерфейс.
Убедиться, что выбор блюда корректно отображается в UI.
Нажать кнопку подтверждения регистрации.
Проверить, что вызов метода registerPrisoner в контроллере выполнен с корректными параметрами.
Критерии приемки:

Поля отображаются и доступны для ввода.
Кнопка "Подтвердить регистрацию" становится активной только при валидных данных.
Выбор блюда отображается корректно в интерфейсе.
Метод регистрации вызывается с ожидаемыми данными.
Инструменты: Junit, Mockito, Selenium
