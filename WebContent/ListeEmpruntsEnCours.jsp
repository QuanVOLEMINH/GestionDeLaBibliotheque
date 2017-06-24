<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=iso-8859-1" %>

<%-- Import de la classe ArrayList --%>
<%@ page import="java.util.ArrayList"%>

<%-- Instantiation du Bean permettant l'accès à la base de données --%>
<jsp:useBean id="compBD" class="biblio.ComposantBDEmprunt" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Projet Bibliothèque</title>
	<link href="styles/styles.css" media="all" rel="stylesheet" type="text/css">
</head>

<body>
	<h1>Mini application bibliothèque<h1>
	<hr/>

	<h2>Liste de tous les emprunts en cours :</h2>

	<%
	ArrayList<String[]> emprunts;
	Boolean listeVide = true;
	// Appel de la méthode "listeTousEmployes"
	if (request.getParameter("usager-rechercher")==null){
		emprunts = compBD.listeEmpruntsEnCours();
		if (emprunts.size()!=0) listeVide=false;
	}
	else {
		String titre = request.getParameter("usager-rechercher");
		emprunts = compBD.listeEmprunts(titre);
		if (emprunts.size()!=0) listeVide=false;
	}
	
	if(!listeVide) {
	%>
	<%-- Tableau HTML avec les titres de colonnes --%>
	<table border="1">
		<tr style="font-weight: bold">
			<td align="center">ID exemplaire</td>
			<td align="center">ID usager</td>
			<td align="center">Date emprunt</td>
			<td align="center">Rendre</td>
		</tr>
	<%
		// On parcours la liste des emprunts
		for(int i=0;i<emprunts.size();i++) {
		// A chaque "tour" de la boucle, on récupère les infos
		// sur un emprunt (dans un tableau de 3 chaînes de caractères)
		// Cf. méthode "listeTousemprunts" dans "ComposantBD"
		String[] emprunt = (String[])emprunts.get(i);
	%>
		<tr>
			<td><%=emprunt[1]%></td>
			<td><%=emprunt[0]%></td>
			<td><%=emprunt[2]%></td>
			<td align="center"><a href="Rendre.jsp?id=<%=emprunt[1]%>"><img src="images/building_go.png" border=0/></a></td>
		</tr>
	<%
		}
	}
	else {
	%>
		<p style="font-weight:bold; color:red">Aucun emprunt en cours</p>
	<%
	}
	%>
	</table>
	<p align="center"><a href="/bibliotheque/">Retour...</a></p>

</body>
</html>