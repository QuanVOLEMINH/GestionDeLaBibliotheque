<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=iso-8859-1" %>

<%-- Import de la classe ArrayList --%>
<%@ page import="java.util.ArrayList"%>

<%-- Instantiation du Bean permettant l'accès à la base de données --%>
<jsp:useBean id="compBD" class="biblio.ComposantBDUsager" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Projet Bibliothèque</title>
	<link href="styles/styles.css" media="all" rel="stylesheet" type="text/css">
</head>

<body>
	<h1>Mini application bibliothèque<h1>
	<hr/>
	<% 
		String usager[] = new String[5];
		usager[0] = request.getParameter("id");
		Boolean resultat=false;
		if (request.getParameter("submit-modifier")!=null){
			usager[1] = (request.getParameter("nom")).toUpperCase();
			usager[2] = request.getParameter("prenom");
			usager[3] = request.getParameter("statut");
			usager[4] = request.getParameter("email");
			// Appel de la méthode modifierUsager qui renvoie true si la modification a réussi
			try {
				compBD.modifierUsager(usager[0],usager[1],usager[2],usager[3],usager[4]);
			}
			catch(java.sql.SQLException e) {
				resultat=false;
				usager = compBD.getUsager(usager[0]);
			}
		}
		if (resultat==false || request.getParameter("submit-modifier")==null) {
			usager = compBD.getUsager(usager[0]);
		}
	%>
	<h2>Fiche de <%=usager[1]%> (n°<%=usager[0]%>)</h2>

	<%-- Tableau HTML avec les titres de colonnes --%>
	<table border="1">
		<tr style="font-weight: bold">
			<td>ID</td>
			<td>Nom</td>
			<td>Prénom</td>
			<td>Statut</td>
			<td>Email</td>
		</tr>
		<tr>
			<td><%=usager[0]%></td>
			<td><%=usager[1]%></td>
			<td><%=usager[2]%></td>
			<td><%=usager[3]%></td>
			<td><%=usager[4]%></td>
		</tr>
	</table>
	
	<form name="form-modifier" id="form-modifier" action="ModifierUsager.jsp" method="POST">
	<table border=0>
	<input type="hidden" name="id" value="<%=usager[0]%>">
	<tr><td>Nom</td><td><input type="text" name="nom" size="40" value="<%=usager[1]%>"/></td></tr>
	<tr><td>Prénom</td><td><input type="text" name="prenom" size="40" value="<%=usager[2]%>"/></td></tr>
	<tr><td>Statut</td><td><select name="statut"><option value="Etudiant" <%=usager[3].equals("Etudiant") ? "selected" : ""%>>Etudiant</option><option value="Enseignant" <%=usager[3].equals("Enseignant") ? "selected" : ""%>>Enseignant</option></select></td></tr>
	<tr><td>Email</td><td><input type="text" name="email" size="40" value="<%=usager[4]%>"/></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td><input type="submit" name="submit-modifier" id="submit" value="Modifier"></td></tr>
	</table>
	</form>
	
	<form name="form-effacer" id="form-effacer" action="ModifierUsager.jsp" method="POST">
	<input type="hidden" name="id" value="<%=usager[0]%>">
	Pour supprimer cet usager entrez son numéro et validez : <input type="text" name="id-effacer" size="5" /><input type="submit" name="submit-effacer" id="submit" value="Effacer"></form>
	
	<% if (request.getParameter("submit-effacer")!=null){
		String idAEffacer = request.getParameter("id-effacer");
		if (!usager[0].equals(idAEffacer)) {
	%>
		<p style="font-weight:bold; color:red">Les numéros ne correspondent pas !</p>
	<% 
		}
		else {
			try {
				compBD.supprimerUsager(usager[0]);
	%>
				<p style="font-weight:bold; color:green">L'usager n°<%=usager[0]%> a été effacé !</p>
	<%
			}
			catch(java.sql.SQLException e) {
	%>		
			<p style="font-weight:bold; color:red">Impossible d'effacer cet usager, vérifiez qu'il n'a pas d'emprunts en cours !</p>
	<% 		}
		}
       }
	%>
	
	<p align="center"><a href="/bibliotheque/">Retour...</a></p>

</body>
</html>

