CREATE DATABASE IF NOT EXISTS tro_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tro_db;

CREATE TABLE Users(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255),
    role VARCHAR(20),
    status BOOLEAN,
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    created_at DATETIME
);

CREATE TABLE Categories(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    status BOOLEAN
);

CREATE TABLE Rooms(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    price DECIMAL(12,2),
    area DOUBLE,
    address TEXT,
    description TEXT,
    image VARCHAR(255),
    status BOOLEAN,
    category_id BIGINT,
    owner_id BIGINT,
    
    -- Phase 4 fields
    latitude DOUBLE,
    longitude DOUBLE,
    has_wifi BOOLEAN DEFAULT FALSE,
    has_air_conditioner BOOLEAN DEFAULT FALSE,
    has_washing_machine BOOLEAN DEFAULT FALSE,
    has_parking BOOLEAN DEFAULT FALSE,
    has_camera BOOLEAN DEFAULT FALSE,
    has_guard BOOLEAN DEFAULT FALSE,
    has_mezzanine BOOLEAN DEFAULT FALSE,
    gender_allowed VARCHAR(20) DEFAULT 'ALL', -- NAM, NU, ALL
    
    FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE SET NULL,
    FOREIGN KEY (owner_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Favorites(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    room_id BIGINT,
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Rooms(id) ON DELETE CASCADE
);

CREATE TABLE Reviews(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_id BIGINT,
    user_id BIGINT,
    rating INT,
    comment TEXT,
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Rooms(id) ON DELETE CASCADE
);

CREATE TABLE Reports(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_id BIGINT,
    user_id BIGINT,
    reason VARCHAR(255),
    description TEXT,
    status VARCHAR(50) DEFAULT 'PENDING',
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Rooms(id) ON DELETE CASCADE
);

-- Phase 5 fields
CREATE TABLE Conversations(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT,
    landlord_id BIGINT,
    room_id BIGINT,
    updated_at DATETIME,
    FOREIGN KEY(student_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(landlord_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(room_id) REFERENCES Rooms(id) ON DELETE CASCADE
);

CREATE TABLE Messages(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    conversation_id BIGINT,
    sender_id BIGINT,
    content TEXT,
    created_at DATETIME,
    FOREIGN KEY(conversation_id) REFERENCES Conversations(id) ON DELETE CASCADE,
    FOREIGN KEY(sender_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Bookings(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_id BIGINT,
    student_id BIGINT,
    move_in_date DATE,
    people_count INT,
    note TEXT,
    status VARCHAR(20),
    created_at DATETIME,
    approved_at DATETIME,
    rejected_at DATETIME,
    FOREIGN KEY(room_id) REFERENCES Rooms(id) ON DELETE CASCADE,
    FOREIGN KEY(student_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- Insert Sample Categories
INSERT INTO Categories (name, description, status) VALUES ('Phòng trọ', 'Phòng trọ phổ thông', TRUE);
INSERT INTO Categories (name, description, status) VALUES ('Chung cư mini', 'Chung cư mini đầy đủ nội thất', TRUE);

-- Insert Sample Admin
INSERT INTO Users (full_name, email, phone, password, role, status, email_verified, phone_verified, created_at) 
VALUES ('Admin', 'admin@tro.com', '0123456789', '$2a$10$wY.uO/yS6Z4C2lZt21Xv.evUeU1hL1vGq.z7hKq4Yc8y/5L6d.5G6', 'ADMIN', TRUE, TRUE, TRUE, NOW()); -- Password: admin123

CREATE TABLE Payments(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    booking_id BIGINT,
    order_code BIGINT UNIQUE,
    amount DECIMAL(12,2),
    payment_method VARCHAR(50),
    status VARCHAR(20),
    checkout_url TEXT,
    paid_at DATETIME,
    created_at DATETIME,
    FOREIGN KEY (booking_id) REFERENCES Bookings(id) ON DELETE CASCADE
);

CREATE TABLE PaymentTransactions(
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    payment_id BIGINT,
    payos_transaction_id VARCHAR(100),
    amount DECIMAL(12,2),
    status VARCHAR(50),
    raw_data LONGTEXT,
    created_at DATETIME,
    FOREIGN KEY(payment_id) REFERENCES Payments(id) ON DELETE CASCADE
);
