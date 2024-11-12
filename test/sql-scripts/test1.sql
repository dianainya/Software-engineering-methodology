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
