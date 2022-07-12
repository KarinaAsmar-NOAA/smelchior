<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>NOAA - NCEP - EMC Obs Dump Monitor</title>
<style type="text/css" media="all" title="stylesheet">@import url(css/container.css);</style>
<style type="text/css" media="all" title="stylesheet">@import url(css/master.css);</style>
<link rel="icon" type="image/ico" href="icon/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="description" content="NOAA - NCEP - EMC Data Processing"> 
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAZfIm7vj2L5-Jd1mHplA6LRR8P6Sxm61KIrkZZ6cHFMbVOak7JhRT_GIr5a15AVm9HPAhX_oVC3vATg"
type="text/javascript"></script>
<!--<script src="http://acme.com/javascript/Clusterer2.jsm" type="text/javascript"></script>-->
<script src="js/Clusterer2.js" type="text/javascript"></script>
</head>
<body onunload="GUnload()">

<?php 
// get incoming url argument(s), if any
if ($_GET['ccs']!="dev" && $_GET['ccs']!="prod")
 {
  print("Invalid ccs option: \"$_GET['ccs']\"");
  exit;
 }
else 
 {
  $ccs=$_GET['ccs'];
 }
# Hard set the following variables until this feature is automated
# (still in development)
$net='nam';
$grp='adpsfc';
$tnk='000001';
$dtg='2011062412';
#if (isset($_POST['fsdtg']))
# {$archivedtg=$_POST['fsdtg'];}
#$net=$_GET['net'];
#$grp=$_GET['grp'];
#$tnk=$_GET['tnk'];
#$dtg=$_GET['dtg'];

# set up tank to name array
require("tankname.php");

# if no ccs selected, default to prod machine 
if ($ccs=="") {$ccs="prod";}
# determine which machine is prod and which machine is dev
require("devprod.php");
?>

<?php
$homelink="index.php?log=home&ccs=$ccs"; 
$plotlink="stnplts.php";
?>

<div id="wrap">
<div id="header">
<? require("header_stnplts.php"); ?>
</div> <!-- header -->
<div id="nav">
 <div id="menuh-container">
  <div id="menuh">
   <?
   if ($net=="ndas") {require("nav_namdumpgrp.php");}
   else {require("nav_${net}dumpgrp.php");} 
   ?>
  </div> <!-- menuh -->
 </div> <!-- menuh-container -->
</div> <!-- nav -->

<div id="main"> 

<?php
# build xml file name
$dtg="20110624";
$cyc="12";
#$net="gdas";
$xmlfile="xml/$net/$dtg/$net.$grp.$tnk.$dtg${cyc}.xml";
?>

<?
if (isset($grp))
 {print("<p>$grp - $tnk / $tnknmarr[$tnk] - $dtg - $cyc</p>");}
?>

<div id="map" style="width: 796px; height: 700px"></div>
<!-- <div id="side_bar"></div> -->

<script type="text/javascript">
//<![CDATA[

if (GBrowserIsCompatible())
 { 
  // this variable will collect the html which will eventually be placed in 
  // the side_bar
  //var side_bar_html = "";
    
  // arrays to hold copies of the markers used by the side_bar
  // because the function closure trick doesnt work there
  var gmarkers = [];

  // A function to create the marker and set up the event window
  function createMarker(point,name,html)
   { 
    var marker = new GMarker(point);
    GEvent.addListener(marker, "click", function()
     { 
      marker.openInfoWindowHtml(html);
     });
    // save the info we need to use later for the side_bar
    gmarkers.push(marker);
    // add a line to the side_bar html
    //side_bar_html += '<a href="javascript:myclick(' + (gmarkers.length-1) + ')">' + name + '<\/a><br>';
    return marker;
   }

  // This function picks up the click and opens the corresponding info window
  function myclick(i)
   { 
    GEvent.trigger(gmarkers[i], "click");
   }

  // create the map
  var map = new GMap2(document.getElementById("map"));
  map.addControl(new GLargeMapControl());
  map.addControl(new GMapTypeControl());
  //map.setCenter(new GLatLng( 20.907787,-39.359741), 2);
  map.setCenter(new GLatLng( 20.0, 0.0), 2);

  // create cluster
  var clusterer = new Clusterer(map);

  // Read the data from *.xml
  //GDownloadUrl("xml/gdas.adpsfc.NC000002.20110321.xml", function(doc)
  //GDownloadUrl("xml/us_markers.xml", function(doc)
  GDownloadUrl("<?=$xmlfile?>", function(doc)
   { 
    var xmlDoc = GXml.parse(doc);
    var markers = xmlDoc.documentElement.getElementsByTagName("marker");
    for (var i = 0; i < markers.length; i++)
     { 
      // obtain the attribues of each marker
      var lat = parseFloat(markers[i].getAttribute("lat"));
      var lng = parseFloat(markers[i].getAttribute("lng"));
      var point = new GLatLng(lat,lng);
      var html = markers[i].getAttribute("html");
      var label = markers[i].getAttribute("label");
      // create the marker
      var marker = createMarker(point,label,html);
      //map.addOverlay(marker);
      clusterer.AddMarker(marker,"title");
     }
    // put the assembled side_bar_html contents into the side_bar div
    //document.getElementById("side_bar").innerHTML = side_bar_html;
   });
 }
else
 { 
  alert("Sorry, the Google Maps API is not compatible with this browser");
 }


//]]>
</script>

</div> <!-- main -->

 <div id="footer">
 </div> <!-- footer -->

</div> <!-- wrap -->

</body>
</html>
