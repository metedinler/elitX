# Copilot Kuralları

0. Copilot ve tüm ajanlar bu belgeyi okuyacak ve kuralların uygulanmasını sağlayacaktır. Kurallardan sapma olamaz.
1.her promt ayri bir is degildir. her promt bir oncekinin uzerine yapilan ekleme veya gelistirmedir.  
2. Program dili Türkçe dir. değişkenler, veri yapıları, veritabanları, sınıfların, metotların , bagımsız fonksıyonların adları Türkçe olacaktır.

3. program tasarım ve planlarına ve kurallarına kesinlikle uyulacaktır. hıcbır sekılde sahte kod yazılmayacaktırç her ne ad altında olursa olsun kesınlıkle yapılmayacaktır. yanı pseudo, dump, placeholder, temp vs olmayacaktır, varsayımlar ve bılınmeyenler sorulacak planın eksıklıklerı tamamlanacak ve plan.md'ye sadece eklemeler yapilarak yazilacaktir. sadece biten plan maddeleri bitti olarak isaretlenecektir. bu sekilde uygulanmayan isler bilinir.

4. programda modüller silinmeyecektir. sılınması gereken moduller kullanılmayanlar dızınıne kaldırılır, kullanılmayanlar dızını calısma klasorunde gurultu yapmaması ıcın calısma dızını dısında olmalıdır.

5. programın her adımında yerel git ve internet gitine yükleme yapılacaktır. her adım her promt anlamında degıldır.

6. programın çalışma ilkeleri ve tasarım artefactı ve programın her modulünün, her sınıfının, her metodun ve her bağımsız fonksiyonun görevi üretildiğinde veya üzerinde değişiklik yapıldığında programcınınelkıtabı.md ye yazılacaktır. degıskenlerın, verı yapılarının amacı ve gorevlerı ve sınırları, degıdken tıpı, sınıf ve metodun gırıslerı ve cıkısları yazılacaktır.

7 programın her aşamasında özellikleri Readme.md ye yazılacak

8 yapılan her değişiklik değişiklikler.md dosyasına yazılacak

9 oyunun her aşamasında yerel git reposuna yüklenecek. her önemli değişiklikte internete push edilecek

10 git adresi https://github.com/metedinler/elitX dır.

11. Geliştirme planı .copilot/plan.md dosyasında tutulacaktır. Her adımda planı kontrol et ve takip et. Plan güncellendiğinde dosyayı güncelle ve ilerlemeyi işaretle.

12. Mutlak Uyum Protokolü (Zorunlu)
- Her geliştirme turu başlamadan önce: Kurallar.md + plan.md + istekler.md okunur.
- Her geliştirme turu sonunda: plan.md append-only güncellenir, sadece gerçekten biten maddeler "Tamamlandı" yapılır.
- Kod değişikliği varsa: programcı el kitabı + README + değişiklikler belgeleri de aynı turda güncellenir.
- Kod tarafında "tamamlandı" denilen her madde terminalde en az bir çalıştırma/doğrulama ile kanıtlanır.
- Belge-kod farkı varsa belge değil kod gerçek kabul edilir; plan'a "Yapılmadı/Kısmi" olarak yazılır.
- Sahte kod, boş iskelet, placeholder, temp, TODO bırakmak yasaktır.
- Uygulama yapılamayan madde olursa nedeni açık yazılır ve alternatif plan maddesi plan.md'ye eklenir.

13. Sapma Yönetimi (Zorunlu)
- Kurallara aykırı bir durum tespit edilirse önce aykırılık listelenir, sonra düzeltme adımları plan.md'ye eklenir.
- "Yapıldı" ifadesi yalnızca kod, belge ve test/çalıştırma birlikte tamamlandıysa kullanılabilir.
- Bu kurallar üstündür; yeni promptlar mevcut planın devamı olarak uygulanır.