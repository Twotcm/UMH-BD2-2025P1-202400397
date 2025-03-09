CREATE TABLE Cuentas (
    id_cuenta INT PRIMARY KEY AUTO_INCREMENT,
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0,
    total_debitos DECIMAL(10,2) NOT NULL DEFAULT 0,
    total_creditos DECIMAL(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE Transacciones (
    id_transaccion INT PRIMARY KEY AUTO_INCREMENT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    numero_cuenta VARCHAR(20) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    tipo ENUM('debito', 'credito') NOT NULL,
    FOREIGN KEY (numero_cuenta) REFERENCES Cuentas(numero_cuenta)
);

DELIMITER //
CREATE PROCEDURE RegistrarTransaccion(
    IN p_numero_cuenta VARCHAR(20),
    IN p_monto DECIMAL(10,2),
    IN p_tipo ENUM('debito', 'credito')
)
BEGIN
    DECLARE v_saldo_actual DECIMAL(10,2);
    IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE numero_cuenta = p_numero_cuenta) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cuenta no existe.';
    END IF;
    SELECT saldo INTO v_saldo_actual FROM Cuentas WHERE numero_cuenta = p_numero_cuenta;
    IF p_tipo = 'debito' AND v_saldo_actual < p_monto THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Saldo insuficiente para realizar el débito.';
    END IF;
    INSERT INTO Transacciones (numero_cuenta, monto, tipo)
    VALUES (p_numero_cuenta, p_monto, p_tipo);
    IF p_tipo = 'debito' THEN
        UPDATE Cuentas
        SET total_debitos = total_debitos + p_monto,
            saldo = saldo - p_monto
        WHERE numero_cuenta = p_numero_cuenta;
    ELSE
        UPDATE Cuentas
        SET total_creditos = total_creditos + p_monto,
            saldo = saldo + p_monto
        WHERE numero_cuenta = p_numero_cuenta;
    END IF;

END //
DELIMITER ;
