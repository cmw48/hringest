<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>

<!-- created by cmw48 - creates a mysqldump formatted text file (*.sql) to load hr data into mySql tables -->
  
  <xsl:template match="terminations">
  
    <!--Select current element and all descendants  -->
  <xsl:apply-templates select="*"/>
  <!--xsl:value-of select="."/-->
  <xsl:if test="position()!=last()">),(</xsl:if>   
</xsl:template>
  <xsl:template match="/terminations">
    -- MySQL dump 10.13  Distrib 5.1.34, for unknown-linux-gnu (x86_64)
    --
    -- Host: localhost    Database: newhr_cmw48
    -- ------------------------------------------------------
    -- Server version       5.1.34-community
    
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
    -- Table structure for table `vivoterm`
    --
    
    DROP TABLE IF EXISTS `vivoterm`;
    /*!40101 SET @saved_cs_client     = @@character_set_client */;
    /*!40101 SET character_set_client = utf8 */;
    CREATE TABLE `vivoterm` (
    `emplId` int(15) NOT NULL DEFAULT '0',
    `posnId` varchar(15) DEFAULT NULL,
    `event` varchar(255) DEFAULT NULL,
    `retActive` varchar(255) DEFAULT NULL,
    `emplFullName` varchar(255) DEFAULT NULL,
    `effDate` varchar(255) DEFAULT NULL,
    `hireDate` varchar(255) DEFAULT NULL,
    `contServDate` varchar(255) DEFAULT NULL,
    `currentlyActive` varchar(255) DEFAULT NULL,
    `jobCode` varchar(255) DEFAULT NULL,
    `jobCodeFamily` varchar(255) DEFAULT NULL,
    `reason` varchar(255) DEFAULT NULL,
    
    PRIMARY KEY (`posnId`) USING BTREE,
    KEY `emplId` (`emplId`) USING BTREE
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
    /*!40101 SET character_set_client = @saved_cs_client */;
    
    --
    -- Dumping data for table `vivoterm`
    --
    
    LOCK TABLES `vivoterm` WRITE;
    
    INSERT INTO `vivoterm` VALUES <xsl:for-each select="termination">('<xsl:value-of select="emplId"/>','<xsl:value-of select="posnId"/>','<xsl:value-of select="event"/>','<xsl:value-of select="retActive"/>','<xsl:value-of select="emplFullName"/>','<xsl:value-of select="effDate"/>','<xsl:value-of select="hireDate"/>','<xsl:value-of select="contServDate"/>','<xsl:value-of select="currentlyActive"/>','<xsl:value-of select="jobCode"/>','<xsl:value-of select="jobCodeFamily"/>','<xsl:value-of select="reason"/>')<xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each>;
    /*!40000 ALTER TABLE `vivoterm` ENABLE KEYS */;
    UNLOCK TABLES;
    /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
    
    /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
    /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
    /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
    /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
    /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
    /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
    /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
  </xsl:template>
 
  

</xsl:stylesheet>
