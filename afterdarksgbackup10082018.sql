-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: afterdarksg
-- ------------------------------------------------------
-- Server version	5.5.60-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bars_info`
--

DROP TABLE IF EXISTS `bars_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bars_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `about` text,
  `price` varchar(45) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `loc_lat` double DEFAULT NULL,
  `loc_long` double DEFAULT NULL,
  `address_full` varchar(255) DEFAULT NULL,
  `address_summary` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `passcode` varchar(45) DEFAULT NULL,
  `openingHours` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bars_info`
--

LOCK TABLES `bars_info` WRITE;
/*!40000 ALTER TABLE `bars_info` DISABLE KEYS */;
INSERT INTO `bars_info` VALUES (1,'D\'Underground Bar & Club','Beer Factory offers the best deals on Afterdark. Located 300m away from Raffles Place MRT, BF promises a great round of post-work drinks for you and your colleagues. Having difficulties? Contact Help @ +65 91514447','$$','67376269',NULL,1.3061,103.831,'360 Orchard Road, #B1-00 International Building, 238869','Orchard','www.google.com','1234',NULL),(2,'The Music Room','We are located in SIA Sports & Recreation club, just a 10 minutes walk from SUTD and the newly opened Upper Changi MRT station. The bar is accessible to all! Having difficulties? Contact Help @ +65 91514447','$$','97483602',NULL,1.344177,103.964998,'726 Upper Changi Rd E, Singapore 486046','SUTD','www.google.com','1122',NULL),(3,'Beer Factory','Beer Factory offers the best deals on Afterdark. Located 300m away from Raffles Place MRT, BF promises a great round of post-work drinks for you and your colleagues. Having difficulties? Contact Help @ +65 91514447','$','67376269',NULL,NULL,NULL,'25 Church St, #01-07, Singapore 049482','Raffles Place/Telok Ayer',NULL,'3331',NULL),(5,'Backbenchers','Located at the heart of Club Street.  Having difficulties? Contact Help @ +65 91514447','$$$',NULL,NULL,1.280951,103.845785,'#01-01, 17 Ann Siang Road, Singapore 069697','Club Street',NULL,'8912',NULL),(6,'Sleeping Giants','Having difficulties? Contact Help @ +65 91514447','$$',NULL,NULL,NULL,NULL,'217 E Coast Rd, Singapore 428915','Katong',NULL,'2244',NULL),(7,'Sticky Fingers','We pride ourselves on the authenticity of our products, and of course our proximity to popular nightlife spots. So head on down to grab your pres at crazy prices! Having difficulties? Contact Help @ +65 91514447','$$$',NULL,NULL,1.2888016,103.8438803,'11 Keng Cheow St, #01-05/06, Singapore 059608','Clarke Quay',NULL,'7890',NULL),(8,'Amber Nectar','','$$$',NULL,NULL,1.2917629,103.8416828,'11 Unity St, 01-10/11, Singapore 237995','Robertson Quay',NULL,'4321',NULL),(9,'Paulaner','Located just 200m away from Zouk and F.Club, why pay for drinks in the club when you can drink 4 times the alcohol at the same price with us? Having difficulties? Contact Help @ +65 91514447','$$$',NULL,NULL,1.2906336,103.8454564,'3 179021, Clarke Quay, Singapore','Clarke Quay',NULL,'5432',NULL),(12,'Secret Lab','A Customised Liquid Buffet Concept in the heart of Rochor. Having difficulties? Contact Help @ +65 91514447','$$',NULL,NULL,NULL,NULL,'30 Dickson Road, Singapore 209512','Rochor',NULL,'1113',NULL),(13,'The Merry Lion','Singapore\'s only full-time comedy club. Head on down for a unique experience that will guarantee you the tickles. Having difficulties? Contact Help @ +65 91514447','$$',NULL,NULL,NULL,NULL,'8b Circular Road, Singapore 049364','Boat Quay',NULL,'2222',NULL),(14,'Afterhours Club Street','Located in Singapore\'s prime drinking street, Afterhours presents an opportunity for you to network with your mates after a long day at work. Having difficulties? Contact Help @ +65 91514447','$$',NULL,NULL,NULL,NULL,'93 Club St, Singapore 069461','Club Street',NULL,'1114',NULL),(15,'Afterhours Siglap','After conquering Club Street, Afterhours has expanded their reach over to the jewel in the east. Having difficulties? Contact Help @ +65 91514447','$$',NULL,NULL,NULL,NULL,'924 East Coast Rd, Singapore 459115','Siglap/ East Coast',NULL,'1115',NULL),(16,'Timbre @ The Substation','Timbre @ The Substation is situated right neside SMU School of Law. Groove to their daily live music performances among the lush and greens!','$$',NULL,NULL,NULL,NULL,'45 Armenian St, Singapore 179936','SMU',NULL,'1212',NULL);
/*!40000 ALTER TABLE `bars_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_claims`
--

DROP TABLE IF EXISTS `discount_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount_claims` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discount_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_claims`
--

LOCK TABLES `discount_claims` WRITE;
/*!40000 ALTER TABLE `discount_claims` DISABLE KEYS */;
INSERT INTO `discount_claims` VALUES (30,45,51,'1526707464'),(31,45,51,'1526732394'),(32,45,91,'1526737467'),(33,45,92,'1526738729'),(34,45,51,'1526742178'),(35,45,51,'1526742198'),(36,45,51,'1526743987'),(37,45,51,'1526744042'),(38,45,51,'1526744065'),(39,46,95,'1526744106'),(40,45,86,'1526744157'),(41,46,93,'1526744230'),(42,47,67,'1526745144'),(43,47,94,'1526745243'),(44,47,51,'1526745306'),(45,46,67,'1526745373'),(46,45,77,'1526745651'),(47,45,51,'1526745727'),(48,45,67,'1526746787'),(49,45,70,'1526746940'),(50,45,51,'1526747493'),(51,45,51,'1526747925'),(52,47,51,'1526748643'),(53,45,67,'1526748714'),(54,45,92,'1526756659'),(55,45,51,'1526960510'),(56,45,51,'1526964333'),(57,46,51,'1527949135'),(58,45,51,'1528017869'),(59,45,51,'1528018008'),(60,47,51,'1528018209'),(61,49,51,'1528440569'),(62,45,65,'1528444477'),(63,46,51,'1528629357'),(64,45,51,'1528689995'),(65,46,51,'1528862541'),(66,45,121,'1530698830'),(67,45,121,'1531496992'),(68,71,172,'1532689789'),(69,36,121,'1533220743'),(70,36,121,'1533220803'),(71,36,207,'1533308840');
/*!40000 ALTER TABLE `discount_claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  `description` text,
  `bar_id` int(11) DEFAULT NULL,
  `amount` text,
  `exclusive` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `curAvailCount` int(11) NOT NULL DEFAULT '0',
  `maxAvailCount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (30,'Heineken 6 Bottles',' ',4,'$33+',0,5,0,10),(31,'Happy Hour','Everyday 4pm-9pm\n\nDrinks: \nBeer Pint $10\n15% off spirits by glass\nMojitos $10\n\nFood:\nChicken Wings: $8\nHotdogs & Fries: $8\nFrench Fries: $4',4,'$10',0,0,0,10),(32,'Dozen Shots','12 Housepour Shots for $60nett!  5:00 to 11 :00 pm : Tuesday . Wednesday . Thursday  . Friday . Saturday 5:00 to 9:00 pm',7,'$60',0,4,5,10),(33,'3 Pints Beer','Schlenkerla Helles Lager from Germany,\nAll day promotion, enjoy your service charge waiver with Afterdark.   \n$25+',8,'$25',1,6,0,75),(34,'3L Beer Tower','Schlenkerla Helles Lager from Germany \nAll day promotion, enjoy your service charge waiver with Afterdark.   \n$39+\n\n***Not applicable during EPL match screenings',8,'$39',1,6,0,75),(35,'3 Pints Beer','Charles Wells Dbl Choc Stout.\n All day promotion, enjoy your service charge waiver with Afterdark.    $25+ ',8,'$25',1,6,0,80),(36,'10 Shooters/Shots','$45++ for 10 shooters/shots House pours: Vodka: Smirnoff Gin: Gordon\'s Whiskey: Famous grouse Tequila: Jose cuavero ($50++)  Shooters: Kamikaze Sex on the beach Zytone Melon ball',9,'$45++',1,7,4,10),(37,'Cocktails (Jug)','$45++ Long Island tea, bullfrog, sangria, electrocution, mojito, margarita  $45++',9,'$45++',0,6,10,10),(38,'Crazy Deal','1/2 Pint of all Housepour spirits for only $5++\nTill 5pm-7pm daily**\n\n**we are closed on sundays',5,'$5++',0,5,10,10),(39,'Happy Hour','Beer:\n\n1/2 Pint - $8++\nPint - $10++\nJug - $25++\n\n=======================\n\nHousepour:\n\nWine - Red\nSpirits - Gin,Vodka,Rum,Whiskey\nShots\n\nONLY 10++ EACH\n\nValid till 2359 daily',5,'$8++',0,5,10,10),(40,'Deluxe Twin Btl','Finsbury, Bombay Sapphire, Absolute, Chivas12, Black Label, Jim Beam, Bacardi',5,'$208++',0,4,9,10),(41,'Premium Twin Btl','Hendricks, Grey Goose, Monkey Shoulder, Gold Label, Glenfiddich12, Nikka, All Malt, Old Monk\n\nDaily till 2359',5,'$248++',0,4,9,10),(42,'Martinis 1 for 1','Daily till 2359',5,'$16++',0,5,10,10),(43,'Afterdark Exclusive','This is applicable to all food items till 2359 daily, and can be used together with other promotions',5,'20%',0,6,10,10),(44,'Liquid Buffet','10% off their liquid buffet from mon-thurs, sun. 2200-2330\nGuys: 18.00\nGirls: 15.00\n\nAfterdark special: 10% off + free entry to fleek at Clarke quay',11,'$15',1,7,0,10),(45,'Liquid Buffet (Guys)','$30 (Entry + liquid buffet)',1,'$30',1,10,58,100),(46,'Liquid Buffet (Girls)','$20 (Entry + liquid buffet)',1,'$20',1,10,65,80),(47,'Discount','$15 (entry + 2 drinks)',1,'$15',1,10,41,50),(48,'Liquid Buffet (Girls)','Ladies: $25',2,'$25',1,10,0,10),(49,'Liquid Buffet','$15 Afterdark Exclusive. Sunday-Thursday (all hours)',12,'$15',0,0,46,50),(50,'Liquid Buffet (Guys)','Guys: $30',2,'$30',1,0,0,10),(51,'Black Label','Black Label (+2 Mixers)',2,'$100',1,0,8,10),(52,'Chivas 12YO','Chivas 12 (+2 Mixers)',2,'$100',1,0,8,10),(53,'Monkey Shoulder','Monkey Shoulder (+2 Mixers)',2,'$115',1,0,5,10),(54,'3L Tower','3L Craft Beer Tower',3,'$39',1,0,46,60),(55,'Bottle Exclusive','Selection of Smirnoff Vodka, Clan Gold Whiskey, 1981s',3,'$80',1,0,60,60),(56,'Venue Booking','Book through Afterdark to get 50% off original Booking Fee ($1000)',2,'$500',1,0,3,4),(58,'20% All Food','Enjoy 20% Pizzas, Burgers, Bar bites, Tacos and more (all day)',6,'20%',1,0,39,40),(59,'24H Happy Hour','All day Happy Hour with minimum purchase of 2 towers',6,'HH',1,0,38,40),(60,'Bottle Exclusive','10% off Belvedere and Gold Label',6,'10%',1,0,40,40),(62,'Midweek Show','Includes 1 Midweek show entry and 1 housepour beer (Saves $19)',13,'$15',1,0,10,10),(63,'Saturday Show','Includes 1 Saturday show entry and 1 housepour beer (Saves $19)',13,'$25',1,0,10,10),(64,'Bucket Exclusive','Bucket of 5 Merry Lion Premium Lager (all hours)',13,'$45',1,0,10,10),(65,'Bottle Exclusive','Famous Grouse/ Jim Beam (mixers separate)',14,'$70',1,0,10,10),(66,'Bottle Exclusive','Famous Grouse/ Jim Beam (mixers separate)',15,'$70',1,0,9,10),(67,'Bottle Exclusive','Absolut Blue (mixers separate)',14,'$85',1,0,10,10),(68,'Bottle Exclusive','Absolut Blue (mixers separate)',15,'$85',1,0,10,10),(69,'Cocktails','Selection of: Singapore Sling ($21), Bloody Mary ($21), Black/White Russian ($18), Mojito ($21), Whiskey Sour ($18), Matador ($21), Margarita ($21), Graveyard ($21), Long Island Iced Tea ($28), Longest Island Iced Tea ($33) ',14,'1 for 1',1,0,96,100),(70,'Cocktails','Selection of: Singapore Sling ($21), Bloody Mary ($21), Black/White Russian ($18), Mojito ($21), Whiskey Sour ($18), Matador ($21), Margarita ($21), Graveyard ($21), Long Island Iced Tea ($28), Longest Island Iced Tea ($33) ',15,'1 for 1',1,0,98,100),(71,'SMU Exclusive','Exclusive Happy Hour extension only for SMU Students (with metric card). Befeeter Gin & Tonic @ $5, House wines @$8 & Draught Beer @ $9. T&Cs: 1. Prices are subject to GST & service charge. 2. Not applicable on Friday, Saturday, Public Holiday & Eve of PH 3. Vouchers must be claimed (passcode keyed in) before 9pm.',16,'HH',1,0,287,300);
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `personalized` tinyint(4) NOT NULL DEFAULT '0',
  `wallet` varchar(255) NOT NULL DEFAULT '[]',
  `date_begin` int(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `uuid_UNIQUE` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (43,'01E97FA5-40D4-4138-B55A-E98C9675EDBE','','',0,'[]',1524578798),(44,'6369B006-61B0-49FC-BD75-9B5DE3A7D4ED','','',0,'[{\"id\":26,\"expiry\":1525882056}]',1525881999),(45,'83187749-F090-4606-B189-6203B17BF6B6','','',0,'[]',1525905513),(46,'11AA517D-8D54-4B69-990F-A7154FC2D4FA','','',0,'[]',1525911740),(47,'8784AAD0-DDF5-4427-BB99-C6BD5F5F2965','','',0,'[{\"id\":27,\"expiry\":1525911812}]',1525911756),(48,'EAA78939-817F-45B1-8209-51C289DEA10D','','',0,'[{\"id\":71,\"expiry\":1533887439}]',1525915358),(49,'82D2C6CA-D706-485F-9604-363A0AE3B416','','',0,'[]',1525931772),(50,'F8C0428C-16AC-48AC-8F77-F308260FB468','','',0,'[]',1525938470),(51,'DD4944E5-889A-41EF-A440-0967A1F56FEE','','',0,'[]',1525968809),(52,'E8BA6256-FC32-4061-AE47-04BA8ADD678B','','',0,'[]',1526022246),(53,'4B2D366C-0524-4EA8-9E89-425E2438483F','','',0,'[]',1526028800),(54,'A5131319-7E94-4195-ADA7-ADD52DBE53A4','','',0,'[]',1526108158),(55,'65A147B0-1CAD-4E6D-BD1F-BCF9B18D7053','','',0,'[]',1526133323),(56,'76D195E1-0177-4C6C-A628-AA2F60A3F3D8','','',0,'[{\"id\":45,\"expiry\":1526826581}]',1526228220),(57,'2EAFD29A-CD0E-4FD0-B40B-D3326C71C285','','',0,'[]',1526233012),(58,'66F9FFE9-48DC-4E65-9832-452AB72DD291','','',0,'[]',1526292069),(59,'8C45E233-FF9A-4441-8CF6-D1A4178696A2','','',0,'[]',1526300799),(60,'485D8EA6-BAE6-4D18-9B02-99D7CB0D7BBB','','',0,'[]',1526314756),(61,'DA0B6D1A-42DA-417F-AFE6-12E5B26E5C3D','','',0,'[]',1526573342),(62,'78D610B9-B8A3-4DF3-950F-85368F31184B','','',0,'[]',1526598969),(63,'BFB7ED8F-E6AE-4615-9DA0-2A4295CE696B','','',0,'[{\"id\":45,\"expiry\":1533105447},{\"id\":32,\"expiry\":1533105474}]',1526604403),(64,'FB2F30AA-FD0A-4C1E-A706-EE8561724EBA','','',0,'[]',1526614479),(65,'AD50EA06-D686-4677-9F99-E75601915C0A','','',0,'[]',1526642509),(66,'932FB363-246C-44A3-82CF-223675D08744','','',0,'[{\"id\":45,\"expiry\":1526824856}]',1526644138),(67,'FCF82A58-B49E-48B6-B69D-F883A9CC4A52','','',0,'[]',1526645896),(68,'05C15A7F-36E9-4BA1-96D0-D33FD6896033','','',0,'[]',1526693027),(69,'CCCF33F5-96EF-41F3-AC31-6ED7E2C4DF4B','','',0,'[]',1526704223),(70,'1C7D3448-15E6-45B7-BCCC-3F23D50B5021','','',0,'[]',1526724833),(71,'EF3DDA83-10F8-4C04-9E75-60207E8C1E62','','',0,'[]',1526726296),(72,'B8E81A0E-69B5-4457-84FD-053FABA8AE60','','',0,'[]',1526728218),(77,'33489413-6E1E-4CBB-9660-45302DBB668E','','',0,'[]',1526728528),(79,'59345198-B961-4DE7-AD0B-44726B41CD27','','',0,'[]',1526728580),(86,'20E71ADD-0665-4B6E-84D5-E8B0CEE7D100','','',0,'[{\"id\":49,\"expiry\":1533901445}]',1526729137),(90,'D3C88437-3938-4449-A9CB-638ABC202D79','','',0,'[{\"id\":45,\"expiry\":1526902195}]',1526729319),(91,'B2DB7FA3-0DFE-4506-961C-98EE0D02B1CB','','',0,'[]',1526737319),(92,'97FD3284-0669-42F2-94C6-4540CABC7318','','',0,'[{\"id\":48,\"expiry\":1526929422}]',1526738714),(93,'41BF00E3-8FD6-4D8F-9CFD-8C7077111A68','','',0,'[]',1526741542),(94,'24E7B1BE-6BF8-4970-A3A0-C7099E8169A0','','',0,'[]',1526742361),(95,'85467B83-6FBD-43B7-9602-199A43833113','','',0,'[]',1526743054),(96,'F689155D-13F2-48AF-B382-89397D9DAB82','','',0,'[{\"id\":45,\"expiry\":1526920764}]',1526747958),(97,'F4D87131-1C80-4364-9A97-FB8ABE87F653','','',0,'[]',1526750628),(98,'D4A516A5-F793-4E7C-BD3E-A4446C4C29B2','','',0,'[]',1526793608),(99,'996BA7BE-3C51-4D25-91A3-3A65904A285E','','',0,'[]',1526802583),(100,'D6B4B098-F3A3-404A-BA3D-79A77AD9B9E4','','',0,'[]',1526921115),(101,'D264F2F2-3D98-403F-9E6C-CBB9440D2113','','',0,'[]',1526945395),(102,'53DA31F1-D976-4136-81E5-FB345C4489E6','','',0,'[]',1527366137),(103,'B98B7A30-C0E6-48F4-ADF1-679F6317A1E5','','',0,'[]',1527582645),(104,'41CD8308-AFC9-4001-B7AC-C1E52F821721','','',0,'[]',1527945117),(105,'530ABA8C-4381-4DD6-90DF-88D764587BB1','','',0,'[]',1527946058),(106,'A63B9A9B-D91C-4478-8E2B-B8A43DC7964F','','',0,'[]',1528131342),(107,'845554EC-C0D3-429B-AB09-3C746DF8A83E','','',0,'[]',1528133497),(108,'2E7FE50A-223B-42EA-A5B5-15F66A5F849A','','',0,'[]',1528197681),(109,'E5E9D053-18FB-41F8-B278-7A01AF4463B2','','',0,'[]',1528279391),(110,'2C397221-DC65-4D48-B0A8-0F5AEE7A6A92','','',0,'[]',1528379153),(111,'1C46734A-87E9-4BBB-ABBB-6A59A3A16208','','',0,'[]',1528379316),(112,'71B791A6-55F2-4DD9-95FB-0C409E9A4F2F','','',0,'[]',1528488441),(113,'A61A3361-2BAA-423A-BFC7-F2EC6C24FC4B','','',0,'[]',1528530223),(114,'90391B21-1A12-44C2-BF46-02C00BB7F4A4','','',0,'[]',1528610264),(115,'0E15A05F-9624-4678-B271-C909376DF8FA','','',0,'[]',1528613124),(117,'7064CAD7-38D1-448E-97A2-1A85BBD4ABE2','','',0,'[{\"id\":49,\"expiry\":1528968863}]',1528795930),(118,'6727C152-49E4-444E-860A-C2806ABCEFFB','','',0,'[]',1528803441),(119,'D65CD563-1D8A-400A-9785-9B3158CAA8C2','','',0,'[]',1528805179),(120,'EB2A642C-C1D1-4B7F-A54F-CAC2F1F611DB','','',0,'[]',1529081011),(121,'1721CF2E-812A-4C95-9345-5D0F9DC0CB29','','',0,'[{\"id\":32,\"expiry\":1533716673},{\"id\":46,\"expiry\":1533719469},{\"id\":66,\"expiry\":1533723164}]',1529226125),(122,'31171B64-3AE8-4164-BB64-98754248F996','','',0,'[]',1529233946),(123,'3DBA9341-B09E-4B64-826D-3A71795A2D5C','','',0,'[]',1529241338),(124,'1550F42B-3CD7-4F71-BA9A-70A0C7EBBD0B','','',0,'[]',1529243681),(125,'3D1F47E0-5FEC-4C32-9C26-BE9E153FBDFB','','',0,'[]',1529531300),(126,'2D459AD3-1427-4B80-BFF5-B3B7C30524AB','','',0,'[]',1530014894),(127,'7C277C5B-5C65-4C6D-B87E-5C7389B07322','','',0,'[]',1530017699),(128,'BB5D0987-1E62-4882-A406-92CBEA9E56AE','','',0,'[]',1530276371),(129,'522C1404-F762-47A7-BE83-3481B68D6B00','','',0,'[]',1530276758),(130,'BC998FD0-ECC6-411E-B238-CD96925DBFB1','','',0,'[]',1530279205),(131,'4F7E14FC-E886-4823-9989-1A290EB96267','','',0,'[]',1530283069),(132,'D450907C-7E99-4222-A284-C666E10CA1DE','','',0,'[]',1530604172),(133,'61D29828-7231-48A0-A2B5-0E9311FCEDBF','','',0,'[]',1530606814),(134,'C58AD2F6-2749-42C7-A1A1-12DD425802C5','','',0,'[]',1530777673),(135,'32F876C9-C05D-4936-A7E2-0840188DA3AC','','',0,'[]',1530856885),(136,'D61FEDA6-BB58-45A7-9A02-CC0126E60DD3','','',0,'[{\"id\":54,\"expiry\":1531197614}]',1531024681),(137,'E053B81A-A0C2-4EAB-82E3-45A3C0EC9718','','',0,'[]',1531396730),(138,'BD2D1A8A-B4F4-46D6-B963-E3109051AB49','','',0,'[]',1531405882),(139,'60541289-F4CA-47FB-92FA-91240BA44BFA','','',0,'[]',1531639797),(140,'22CF3D22-BA49-4116-9C1F-FADA50E3A589','','',0,'[{\"id\":70,\"expiry\":1532158644}]',1531718005),(141,'DD19FBD9-E0A0-4D74-BD67-FCA56FBBB875','','',0,'[]',1531814311),(142,'6F076091-BF75-48FA-8DCF-1DE1843F04CF','','',0,'[]',1532042366),(143,'BD27CF94-4D62-4F8E-B10F-859A37D01E8F','','',0,'[]',1532068016),(144,'95FE8A78-8AC0-411C-9C92-DF9A4F637F34','','',0,'[{\"id\":40,\"expiry\":1532266405}]',1532093502),(145,'B9DBAF91-D956-45D3-B8F1-4D4335A33A12','','',0,'[]',1532095924),(146,'6288D0D6-1613-4749-A045-B5E184CE7C3A','','',0,'[{\"id\":54,\"expiry\":1533055817}]',1532098852),(147,'2FA5501B-6352-4234-8E98-225B4CFD3FEE','','',0,'[]',1532155480),(148,'20F728B0-AE73-42CB-B2A0-61A1AD82C2C5','','',0,'[]',1532173044),(149,'D9A9A62A-1803-4153-9190-AF7D8E42ECBF','','',0,'[]',1532190337),(150,'1E8D0481-E8F1-448D-A15E-66501F339BF2','','',0,'[{\"id\":54,\"expiry\":1532363749}]',1532190896),(151,'091CE06D-2D41-409E-BBD6-6A0020FB73D3','','',0,'[]',1532223354),(152,'D12EAE33-CE67-4747-A3D8-0411DF2CBE96','','',0,'[]',1532230238),(153,'F2756772-A40D-455F-8821-759B72C08BA1','','',0,'[]',1532233583),(154,'08710DDE-E5BF-45E9-8132-BDA1F9E817AA','','',0,'[{\"id\":47,\"expiry\":1532408979},{\"id\":54,\"expiry\":1532409041}]',1532236160),(155,'3C46A868-8761-4BB1-BCB1-F6ADC91CC0D1','','',0,'[]',1532255939),(156,'BB22C59C-8055-4865-B20D-B5634B84F3E9','','',0,'[]',1532258370),(157,'5F0E3BD1-5A5B-4EA7-B66A-9E17137A63EA','','',0,'[]',1532350243),(158,'1FBA4ED2-EF17-462D-B20A-E95C42CE93C4','','',0,'[]',1532367994),(159,'8E004E3E-F106-48D6-86C7-C72C926D3AE5','','',0,'[{\"id\":54,\"expiry\":1532570551}]',1532397741),(160,'22C698B5-0E74-49FC-91FA-053896E1BB4F','','',0,'[]',1532412889),(161,'B7007E30-E002-461C-B0E6-461721D95E20','','',0,'[{\"id\":54,\"expiry\":1532599082}]',1532426225),(162,'24446D76-2CA2-4B06-B7CE-DC8B0D9AFD98','','',0,'[]',1532434505),(163,'E518F740-F845-41A8-A21B-0FBE664D2489','','',0,'[]',1532448682),(164,'3F1C12A2-57D2-4B96-B146-2138E1260A44','','',0,'[]',1532452129),(165,'C1F96CEA-8CBA-4D50-ADCD-37710A72D5A5','','',0,'[]',1532486324),(166,'79B378A9-54C3-40BC-9A0E-1EF0B3401841','','',0,'[]',1532502372),(167,'6E1685B3-3E68-4F39-83AF-7C578F8EE7E7','','',0,'[]',1532504857),(168,'DC432DB3-F16C-4CFC-B1E5-98C50D1A8AAD','','',0,'[]',1532511074),(170,'9E99F10C-1813-4C5D-9F7B-E01BDC0A3A58','','',0,'[]',1532576738),(171,'F0B93BAC-4811-4C15-A3FC-0FFF6F50867F','','',0,'[]',1532681066),(172,'DD7F8BBE-0191-4CBF-AEE7-58481563B5CC','','',0,'[]',1532689648),(173,'683EE5AB-CD48-4E8A-8FC7-D5936C7BCCDE','','',0,'[]',1532783514),(174,'80978C2E-EE61-4A9A-B071-1AF902341BC1','','',0,'[]',1532874970),(175,'E4EC9BDB-B1F2-4A32-AB8F-FD61CEDD0D3A','','',0,'[{\"id\":47,\"expiry\":1533109542},{\"id\":54,\"expiry\":1533109550},{\"id\":69,\"expiry\":1533109587},{\"id\":36,\"expiry\":1533109611}]',1532910839),(176,'6720136B-9E83-44E3-92D0-E680CD6867FD','','',0,'[]',1532949152),(177,'4887404F-0123-4131-A45A-1F1CA34BB8BA','','',0,'[]',1532949468),(178,'4BA32BB4-60C8-4040-9D69-E0BCF38D12A8','','',0,'[]',1532951851),(179,'CC2126EF-86E9-4CFF-A5C4-A89C2B5FA7FC','','',0,'[{\"id\":71,\"expiry\":1533127283}]',1532954444),(180,'63F5878B-F446-4F25-B7B9-6E2F92E10731','','',0,'[]',1532956635),(181,'8891263E-A8D1-4319-A09C-BEBA36D5D1DE','','',0,'[]',1532962003),(182,'DAC3E8BD-C228-4586-A714-7E3E483F31F2','','',0,'[]',1533001992),(183,'E49919C8-039C-47E3-A7A5-3D972A52ABD2','','',0,'[{\"id\":46,\"expiry\":1533184529}]',1533011715),(184,'8B1BE5BB-F1F7-4E6F-83ED-30942D490015','','',0,'[]',1533105179),(185,'5E67D628-A53E-447B-B33E-36E282726CD2','','',0,'[]',1533197598),(186,'95D29327-A0C5-44AE-B375-2BCFDF443295','','',0,'[]',1533210577),(187,'DBA0E26C-A673-43CE-95F4-6B02CF9D8768','','',0,'[]',1533214719),(207,'5344D65D-FA64-46D3-89B2-BFEB5808BD3B','','',0,'[]',1533308504),(208,'BF1EBBCE-5A48-4343-90D6-B653DBBD1BDB','','',0,'[{\"id\":56,\"expiry\":1533500758}]',1533327894),(209,'7EB05592-A159-4148-9FEB-A2FB9248AA29','','',0,'[]',1533377548),(210,'03E74344-BA41-43E0-9460-C7301317D863','','',0,'[]',1533389419),(211,'202F6E02-8B20-4D69-BB53-AD971E8844AA','','',0,'[]',1533390128),(212,'57C57DF0-B6B9-46E0-BA3B-5CAC008DF9AC','','',0,'[]',1533391667),(213,'BE72D654-EEF2-4511-BE88-A964F664C2B2','','',0,'[]',1533392541),(214,'4243501F-6D72-4F65-8216-403275318B64','','',0,'[]',1533395085),(215,'BF6F030C-9CB5-45BB-907D-AE7F055801A2','','',0,'[]',1533455700),(216,'857BD11E-6CBA-4F91-89B9-241301308F72','','',0,'[]',1533636095),(217,'29EA1D89-A8B6-45ED-BC4F-7FB950267F1E','','',0,'[{\"id\":58,\"expiry\":1533814663},{\"id\":32,\"expiry\":1533814688},{\"id\":36,\"expiry\":1533876432},{\"id\":54,\"expiry\":1533876473}]',1533641838),(218,'4CB0FB83-78D9-420D-87C3-B6357065FC9C','','',0,'[]',1533646090),(220,'08AB96FD-5984-48BD-B076-90182C7D7F04','','',0,'[]',1533655199),(221,'90C1BE22-E560-40E2-BC68-F0ED0A689029','','',0,'[{\"id\":71,\"expiry\":1533876123},{\"id\":70,\"expiry\":1533876145},{\"id\":46,\"expiry\":1533876155},{\"id\":69,\"expiry\":1533876159}]',1533703305),(222,'3091F28A-2B64-46E5-8BB4-BE5D5569222D','','',0,'[]',1533838610),(223,'8B534EB0-DE70-4D68-8763-2F4BCE6DA4C9','','',0,'[]',1533871031);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-10 11:56:31
