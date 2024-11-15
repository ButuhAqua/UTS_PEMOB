import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import 'base_page.dart';

class DeskripsiPage extends StatelessWidget {
  final HomeController controller;

  DeskripsiPage(this.controller);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      bodyContent: DeskripsiList(), // Gantikan dengan widget DeskripsiList
      selectedIndex: 1, // Deskripsi tab is selected
      controller: controller,
    );
  }
}

class DeskripsiList extends StatelessWidget {
  final List<Map<String, String>> locations = [
    {
      "title": "Kantor Desa Panongan",
      "description": "Kantor pemerintahan yang melayani administrasi dan kebutuhan masyarakat Desa Panongan."
    },
    {
      "title": "SDN Panongan 3",
      "description": "Sekolah dasar yang menyediakan pendidikan bagi anak-anak di Desa Panongan."
    },
    {
      "title": "SMP Bahagia",
      "description": "Sekolah Menengah Pertama Swasta yang memberikan pendidikan lanjutan bagi siswa di Kecamatan Panongan."
    },
    {
      "title": "Puskesmas Panongan",
      "description": "Fasilitas kesehatan utama di Desa Panongan yang melayani masyarakat dengan berbagai layanan medis."
    },
    {
      "title": "Masjid Al Muawanah",
      "description": "Masjid yang menjadi pusat ibadah dan kegiatan keagamaan bagi warga Desa Panongan."
    },
    {
      "title": "Kantor Forum Kerukunan Umat Beragama",
      "description": "Forum untuk diskusi antar umat beragama."
    }

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            title: Text(
              location["title"] ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(location["description"] ?? ""),
            ),
          ),
        );
      },
    );
  }
}
