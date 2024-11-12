-- Test 3: Проверка добавления и связывания заключённых
BEGIN;

INSERT INTO prisoner (id, first_name, patronymic, last_name, weight, birth_date, passport, favorite_dish)
VALUES ('f5e61491-6bcb-4707-8a74-0c3523bd0be6', 'John', 'Michael', 'Doe', 75.5, '1990-01-15', 'AB1234567', NULL),
       ('f5e61491-6bcb-4707-8a74-0c3523bd0be7', 'Jane', 'Anne', 'Smith', 60.2, '1985-06-20', 'CD9876543', NULL);

SELECT * FROM prisoner WHERE id IN ('f5e61491-6bcb-4707-8a74-0c3523bd0be6', 'f5e61491-6bcb-4707-8a74-0c3523bd0be7');

DO
$$
    DECLARE
platform_added boolean := false;
BEGIN
        IF NOT EXISTS (SELECT 1 FROM platform_prisoner WHERE is_active = false) THEN
            INSERT INTO platform_prisoner (floor, first_prisoner, second_prisoner, is_active)
            VALUES (1, 'f5e61491-6bcb-4707-8a74-0c3523bd0be6', 'f5e61491-6bcb-4707-8a74-0c3523bd0be7', false);
            platform_added := true;
END IF;
        IF platform_added THEN
            RAISE NOTICE 'Test 3 - Platform added for prisoners: OK';
ELSE
            RAISE NOTICE 'Test 3 - Platform added for prisoners: FAILED';
END IF;
END
$$;