# ElitX Katmanlari Icin Karar Verici Sistem Secimi

Bu belge, yasayan evren hedefi icin ekonomi, diplomasi, ticaret, karakter gelisimi ve NPC katmanlarinda en uygun karar mekanizmalarini secer.

## 1) Genel Mimari
- Katman 1 (Realtime Cekirdek): deterministic, hizli, yorumlanabilir sistemler
- Katman 2 (Asenkron Analiz/ML): agir modeller, periyodik tahmin
- Katman 3 (Politika Uretimi): dengeleme, parametre guncelleme

## 2) Katman Bazli En Uygun Yontemler

### A) Yasayan Evren Katmani
- Temel: Event Sourcing + Rule Engine
- Neden: kalici etkiler, geri oynatma, denetlenebilirlik
- Ek: hazard tabanli olay tetikleme (agirlikli olasilik)

### B) Irk/Faksiyon Iliskileri ve Diplomasi
- Temel: Utility AI + Iliski Grafi + Durum Makinesi
- Neden: aciklanabilir karar, hizli degerlendirme
- Gelismis: Bayesian trust skoru (asenkron)

### C) Cok Kademeli Gorev Zincirleri
- Temel: HTN (Hierarchical Task Network) + Kosul/Etki kurallari
- Neden: kurye->kacakcilik->kriz->savas gibi dallanmalar kolay modellenir
- Ek: event baglama ile zincir devami

### D) Dinamik Ekonomi ve Kitlik/Bolluk
- Temel: Agent tabanli pazar + arz/talep + mean reversion + sok etkisi
- Neden: hem canli hem kontrol edilebilir piyasa
- ML yardimci: fiyat oynaklik tahmini icin Random Forest/XGBoost (asenkron)

### E) Olay Motoru
- Temel: Weight + Cooldown + Dependency kurallari
- Neden: tekrar eden olay spamini engeller, hikaye akisi verir
- Ek: bolgesel gerilim skoru ile olay agirligi carpani

### F) NPC Kaptanlar (Ticaret/Savas)
- Temel: Behavior Tree + Utility score hibriti
- Neden: taktik ve stratejik kararlar dengelenir
- Ek: tecrube tabanli policy cache

### G) Kesif/Tarama/Anomali
- Temel: Bilgi Sisleri (fog-of-war) + inanc skoru (belief state)
- Neden: kesif oyunu dogal ilerler
- Ek: anomaly classifier (hafif model) asenkron

### H) Oyuncu Kariyer Sistemi
- Temel: Perk/uzmanlik agaci + reputasyon/faksiyon itibar modeli
- Neden: rol secimi kalici etkiler dogurur
- Ek: dinamik odul olcekleme (risk/getiri)

## 3) Programlama Ogeleri (Dil Bagimsiz)
- Komut/Event mimarisi
- Durum makinesi (FSM) ve alt durumlar
- Utility fonksiyonlari
- Behavior Tree dugumleri
- Kural motoru (if/then + agirlik)
- Olasilik dagilimi + deterministic PRNG
- Graph veri modeli (faksiyon iliski agi)
- Snapshot + replay (event sourcing)

## 4) ML/Fuzzy/Normal Mantik Dagilimi
- Realtime cekirdekte:
  - Fuzzy inference (savas/diplomasi mikro karar)
  - Rule-based + utility (ana karar)
- Asenkron tarafta:
  - Random Forest / Gradient Boosting (ekonomi ve risk tahmini)
  - Anomali siniflandirma (opsiyonel)

## 5) Performans Kurallari
- Tur basina karar butcesi (ornegin NPC karar sayisi limiti)
- Agir ML cagrisini frame yerine tur/periyot bazina al
- Sonucu cache et ve son kullanma suresi uygula
- Tum rastgelelik cekirdek tohumu ile deterministik olsun

## 6) Ilk Uygulama Paketi (MVP+)
1. Event Engine (weight+cooldown+dependency)
2. Diplomasi Utility + iliski grafi
3. Gorev zinciri HTN cekirdegi
4. Ekonomi sok + arz/talep dalgasi
5. NPC behavior tree (ticaret/savas)

## 7) Beklenen Kazanim
- Al-sat oyunu -> stratejik yasayan evren
- Oyuncu secimleri kalici sistem etkileri uretir
- Cekirdek farkli dillere tasinabilir kalir
