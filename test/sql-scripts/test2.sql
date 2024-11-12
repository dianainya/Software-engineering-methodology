-- Test 2: Проверка NOT NULL constraints и других ограничений на platform
BEGIN;

DO
$$
    DECLARE
null_violation boolean := false;
BEGIN
BEGIN
INSERT INTO platform (code, name, description, floor_amount, created_at, updated_at)
VALUES (null, 'Test Platform', null, 100, null, null);
EXCEPTION
            WHEN not_null_violation THEN
                null_violation := true;
END;
        IF null_violation THEN
            RAISE NOTICE 'Test 2 - NOT NULL constraint on platform.code: OK';
ELSE
            RAISE NOTICE 'Test 2 - NOT NULL constraint on platform.code: FAILED';
END IF;
END
$$;

INSERT INTO platform (code, name, description, floor_amount, created_at, updated_at)
VALUES ('TEST_CODE', 'Test Platform', 'Description', 100, NOW(), NOW());

SELECT * FROM platform WHERE code = 'TEST_CODE';

DELETE FROM platform WHERE code = 'TEST_CODE';
COMMIT;