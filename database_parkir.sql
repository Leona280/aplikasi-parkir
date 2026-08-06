CREATE DATABASE IF NOT EXISTS parkir;
USE parkir;

CREATE TABLE tb_user (
  id_user INT(11) AUTO_INCREMENT PRIMARY KEY,
  nama_lengkap VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  role ENUM('admin','petugas','owner') NOT NULL,
  status_aktif TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE tb_tarif (
  id_tarif INT(11) AUTO_INCREMENT PRIMARY KEY,
  jenis_kendaraan ENUM('motor','mobil','lainnya') NOT NULL,
  tarif_per_jam DECIMAL(10,0) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tb_area_parkir (
  id_area INT(11) AUTO_INCREMENT PRIMARY KEY,
  nama_area VARCHAR(50) NOT NULL,
  kapasitas INT(5) NOT NULL,
  terisi INT(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE tb_kendaraan (
  id_kendaraan INT(11) AUTO_INCREMENT PRIMARY KEY,
  plat_nomor VARCHAR(15) NOT NULL,
  jenis_kendaraan VARCHAR(20) NOT NULL,
  warna VARCHAR(20) NOT NULL,
  pemilik VARCHAR(100) NOT NULL,
  id_user INT(11) NOT NULL,
  CONSTRAINT fk_kendaraan_user
    FOREIGN KEY (id_user) REFERENCES tb_user(id_user)
) ENGINE=InnoDB;

CREATE TABLE tb_log_aktivitas (
  id_log INT(11) AUTO_INCREMENT PRIMARY KEY,
  id_user INT(11) NOT NULL,
  aktivitas VARCHAR(100) NOT NULL,
  waktu_aktivitas DATETIME NOT NULL,
  CONSTRAINT fk_log_user
    FOREIGN KEY (id_user) REFERENCES tb_user(id_user)
) ENGINE=InnoDB;

CREATE TABLE tb_transaksi (
  id_parkir INT(11) AUTO_INCREMENT PRIMARY KEY,
  id_kendaraan INT(11) NOT NULL,
  waktu_masuk DATETIME NOT NULL,
  waktu_keluar DATETIME DEFAULT NULL,
  id_tarif INT(11) NOT NULL,
  durasi_jam INT(5) DEFAULT NULL,
  biaya_total DECIMAL(10,0) DEFAULT NULL,
  status ENUM('masuk','keluar') NOT NULL,
  id_user INT(11) NOT NULL,
  id_area INT(11) NOT NULL,
  CONSTRAINT fk_transaksi_kendaraan FOREIGN KEY (id_kendaraan) REFERENCES tb_kendaraan(id_kendaraan),
  CONSTRAINT fk_transaksi_tarif FOREIGN KEY (id_tarif) REFERENCES tb_tarif(id_tarif),
  CONSTRAINT fk_transaksi_user FOREIGN KEY (id_user) REFERENCES tb_user(id_user),
  CONSTRAINT fk_transaksi_area FOREIGN KEY (id_area) REFERENCES tb_area_parkir(id_area)
) ENGINE=InnoDB;
