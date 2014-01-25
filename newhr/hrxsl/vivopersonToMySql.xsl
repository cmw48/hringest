<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>

<!-- created by cmw48 - creates a mysqldump formatted text file (*.sql) to load hr data into mySql tables -->
  
<xsl:template match="persons">
  

    <!--Select current element and all descendants  -->
  <xsl:apply-templates select="*"/>
  <!--xsl:value-of select="."/-->
  <xsl:if test="position()!=last()">),(</xsl:if>   
</xsl:template>
  <xsl:template match="/persons">
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
    -- Table structure for table `vivoperson`
    --
    
    DROP TABLE IF EXISTS `vivoperson`;
    /*!40101 SET @saved_cs_client     = @@character_set_client */;
    /*!40101 SET character_set_client = utf8 */;
    CREATE TABLE `vivoperson` (
    `emplId` int(11) NOT NULL DEFAULT '0',
    `netId` varchar(10) DEFAULT NULL,
    `legalFirstName` varchar(255) DEFAULT NULL,
    `legalMiddleName` varchar(255) DEFAULT NULL,
    `legalMiddleInitial` varchar(255) DEFAULT NULL,
    `legalLastName` varchar(255) DEFAULT NULL,
    `legalSocialSuffix` varchar(255) DEFAULT NULL,
    `preferredFirstName` varchar(255) DEFAULT NULL,
    `preferredMiddleName` varchar(255) DEFAULT NULL,
    `preferredMiddleInitial` varchar(255) DEFAULT NULL,
    `preferredLastName` varchar(255) DEFAULT NULL,
    `preferredSocialSuffix` varchar(255) DEFAULT NULL,
    `preferredNameLabel` varchar(255) DEFAULT NULL,
    `preferredNameString` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`emplId`) USING BTREE,
    KEY `netID` (`netId`) USING BTREE
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
    /*!40101 SET character_set_client = @saved_cs_client */;
    
    --
    -- Dumping data for table `vivoperson`
    --
    
    LOCK TABLES `vivoperson` WRITE;
    
    INSERT INTO `vivoperson` VALUES <xsl:for-each select="person">('<xsl:value-of select="emplId"/>','<xsl:value-of select="netId"/>','<xsl:value-of select="legalFirstName"/>','<xsl:value-of select="legalMiddleName"/>','<xsl:value-of select="legalMiddleInitial"/>','<xsl:value-of select="legalLastName"/>','<xsl:value-of select="legalSocialSuffix"/>','<xsl:value-of select="preferredFirstName"/>','<xsl:value-of select="preferredMiddleName"/>','<xsl:value-of select="preferredMiddleInitial"/>','<xsl:value-of select="preferredLastName"/>','<xsl:value-of select="preferredSocialSuffix"/>','<xsl:value-of select="preferredNameLabel"/>','<xsl:value-of select="preferredNameString"/>')<xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each>;
    /*!40000 ALTER TABLE `vivoperson` ENABLE KEYS */;
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
