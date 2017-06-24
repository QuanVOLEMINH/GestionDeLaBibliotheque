<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=iso-8859-1"%>

<%-- Import de la classe ArrayList --%>
<%@ page import="java.util.ArrayList"%>

<%-- Instantiation du Bean permettant l'accès à la base de données --%>
<jsp:useBean id="compBD" class="biblio.ComposantBDLivre" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Projet Bibliothèque</title>
<link href="styles/styles.css" media="all" rel="stylesheet"
	type="text/css">
</head>

<body>
	<h1>
		Mini application bibliothèque
		<h1>
			<hr />
			<%
				Boolean resultat = true;
				String livre[] = new String[5];
				livre[0] = request.getParameter("id");
				if (request.getParameter("submit-modifier") != null) {
					livre[1] = request.getParameter("isbn10");
					livre[2] = request.getParameter("isbn13");
					livre[3] = (request.getParameter("titre")).replace("'","''");
					livre[4] = request.getParameter("auteur");
					// Appel de la méthode modifierlivre
					try {
						compBD.modifierLivre(livre[0], livre[1], livre[2],
								livre[3], livre[4]);
					} catch (java.sql.SQLException e) {
						resultat = false;
						livre = compBD.getLivre(livre[0]);
					}
				}
				if (request.getParameter("submit-modifier") == null) {
					livre = compBD.getLivre(livre[0]);
				}

				String action = request.getParameter("action");
				if (action != null) {
					if (action.equals("ajouter")) {
						compBD.ajouterExemplaire(livre[0]);
					} else if (action.equals("effacer")) {
						String num = request.getParameter("ex");
						compBD.supprimerExemplaire(num);
					}
				}
			%>
			<h2><%=livre[3]%></h2>

			<%-- Tableau HTML avec les titres de colonnes --%>
			<table border="1">
				<tr style="font-weight: bold">
					<td>ISBN-10</td>
					<td>ISBN-13</td>
					<td>Titre</td>
					<td>Auteur</td>
					<td>Nombre d'exemplaires</td>
				</tr>
				<tr>
					<td><%=livre[1] == null ? "" : livre[1]%></td>
					<td><%=livre[2] == null ? "" : livre[2]%></td>
					<td><%=livre[3]%></td>
					<td><%=livre[4]%></td>
					<td><%=compBD.nbExemplaires(livre[0])%></td>
				</tr>
			</table>

			<form name="form-modifier" id="form-modifier"
				action="ModifierLivre.jsp" method="POST">
				<table border=0>
					<input type="hidden" name="id" value="<%=livre[0]%>" />
					<tr>
						<td>ISBN-10</td>
						<td><input type="text" name="isbn10" size="40"
							value="<%=livre[1] == null ? "" : livre[1]%>" /></td>
					</tr>
					<tr>
						<td>ISBN-13</td>
						<td><input type="text" name="isbn13" size="40"
							value="<%=livre[2] == null ? "" : livre[2]%>" /></td>
					</tr>
					<tr>
						<td>Titre</td>
						<td><input type="text" name="titre" size="40"
							value="<%=livre[3]%>" /></td>
					</tr>
					<tr>
						<td>Auteur</td>
						<td><input type="text" name="auteur" size="40"
							value="<%=livre[4]%>" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><input type="submit" name="submit-modifier" id="submit"
							value="Modifier"></td>
					</tr>
				</table>
			</form>

			<%
				if (resultat == false
						&& request.getParameter("submit-modifier") != null) {
			%>
			<p style="font-weight: bold; color: red">
				Modification impossible, le n°ISBN existe peut-être déjà !</span>
				<%
					}
				%>
			
			<h2>Liste des exemplaires</h2>

			<%-- Tableau HTML pour les exemplaires --%>
			<table border="1">
				<tr style="font-weight: bold">
					<td>ID</td>
					<td>Etat</td>
					<td>Supprimer</td>
				</tr>
				<%
					// On parcours la liste des exemplaires
					ArrayList<Integer> exemplaires = compBD.listeExemplaires(livre[0]);
					for (int exemplaire : exemplaires) {
				%>
				<tr>
					<td><%=exemplaire%></td>
					<td><%=compBD.estEmprunte(exemplaire) ? "<span style='font-weight:bold; color:red'>Emprunté</span>"
						: "<span style='font-weight:bold; color:green'>Disponible</span>"%></td>
					<td><a
						href="ModifierLivre.jsp?id=<%=livre[0]%>&action=effacer&ex=<%=exemplaire%>"><img
							src="images/cancel.png" border=0 /></a></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td colspan=3><a
						href="ModifierLivre.jsp?id=<%=livre[0]%>&action=ajouter"%><img
							src="images/add.png" border=0 /></a></td>
				</tr>
			</table>


			<form name="form-effacer" id="form-effacer"
				action="ModifierLivre.jsp" method="POST">
				<input type="hidden" name="id" value="<%=livre[0]%>"> <input
					type="hidden" name="titre" value="<%=livre[3]%>"> Pour
				supprimer ce livre entrez son titre et validez : <input type="text"
					name="titre-effacer" size="50" /><input type="submit"
					name="submit-effacer" id="submit" value="Effacer">
			</form>

			<%
				if (request.getParameter("submit-effacer") != null) {
					String livreAEffacer = request.getParameter("titre-effacer");
					if (!livre[3].equals(livreAEffacer)) {
			%>
			<p style="font-weight: bold; color: red">Les titres ne
				correspondent pas !</p>
			<%
				} else {
						try {
							compBD.supprimerLivre(livre[0]);
			%>
			<p style="font-weight: bold; color: green">
				Le livre "<%=livre[3]%>" a été effacé !
			</p>
			<%
				} catch (java.sql.SQLException e) {
			%>
			<p style="font-weight: bold; color: red">Impossible d'effacer ce
				livre, il doit encore exister des exemplaires en stock !</p>
			<%
				}
					}
				}
			%>

			<p align="center">
				<a href="/bibliotheque/">Retour...</a>
			</p>
</body>
</html>

