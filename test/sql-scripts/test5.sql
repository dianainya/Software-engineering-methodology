-- Test 5: Проверка, что записи заключенных удалены корректно
DELETE FROM prisoner WHERE id IN ('f5e61491-6bcb-4707-8a74-0c3523bd0be6', 'f5e61491-6bcb-4707-8a74-0c3523bd0be7');

DO
$$
    DECLARE
prisoners_left integer := 0;
BEGIN
SELECT COUNT(*) INTO prisoners_left FROM prisoner
WHERE id IN ('f5e61491-6bcb-4707-8a74-0c3523bd0be6', 'f5e61491-6bcb-4707-8a74-0c3523bd0be7');

IF prisoners_left = 0 THEN
            RAISE NOTICE 'Test 5 - Deletion of prisoner records: OK';
ELSE
            RAISE NOTICE 'Test 5 - Deletion of prisoner records: FAILED';
END IF;
END
$$;

COMMIT;