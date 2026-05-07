DROP PROCEDURE IF EXISTS GetPatientDebt;
DELIMITER //
CREATE PROCEDURE GetPatientDebt(
    IN p_patient_id INT,
    IN p_phone VARCHAR(20),
    OUT p_total_debt DECIMAL(15,2),
    OUT p_message VARCHAR(100)
)
BEGIN
    IF p_patient_id IS NULL AND p_phone IS NULL THEN
        SET p_total_debt = 0;
        SET p_message = 'Loi: Vui long nhap ID hoac Phone';
    ELSE
        IF p_patient_id IS NOT NULL THEN
            IF EXISTS (
                SELECT *
                FROM Patients
                WHERE patient_id = p_patient_id
            ) THEN
                SELECT total_debt
                INTO p_total_debt
                FROM Patients
                WHERE patient_id = p_patient_id;
                SET p_message = 'Tra cuu thanh cong';
            ELSE
                SET p_total_debt = 0;
                SET p_message = 'Khong tim thay benh nhan';
            END IF;
        ELSEIF p_phone IS NOT NULL THEN
            IF EXISTS (
                SELECT *
                FROM Patients
                WHERE phone = p_phone
            ) THEN
                SELECT total_debt
                INTO p_total_debt
                FROM Patients
                WHERE phone = p_phone;
                SET p_message = 'Tra cuu thanh cong';
            ELSE
                SET p_total_debt = 0;
                SET p_message = 'Khong tim thay benh nhan'
            END IF;
        END IF;
    END IF;
END //
DELIMITER ;
CALL GetPatientDebt(
    1,
    NULL,
    @total_debt,
    @message
);
SELECT @total_debt, @message;
CALL GetPatientDebt(
    NULL,
    '0901234567',
    @total_debt,
    @message
);
SELECT @total_debt, @message;
CALL GetPatientDebt(
    NULL,
    NULL,
    @total_debt,
    @message
);
SELECT @total_debt, @message;
CALL GetPatientDebt(
    9999,
    NULL,
    @total_debt,
    @message
);

SELECT @total_debt, @message;