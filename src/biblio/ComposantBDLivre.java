package biblio;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Composant logiciel assurant la gestion des livres et des exemplaires de
 * livre.
 */
public class ComposantBDLivre {

	/**
	 * Récupération de la liste complète des livres triée par titre.
	 * 
	 * @return un <code>ArrayList</code> contenant autant de tableaux de String
	 *         (5 chaînes de caractères) que de livres dans la base.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static ArrayList<String[]> listeTousLivres() throws SQLException {

		ArrayList<String[]> livres = new ArrayList<String[]>();

		Statement stmt = Connexion.getConnection().createStatement();
		String query = "select * from livre order by titre";
		ResultSet rset = stmt.executeQuery(query);

		while (rset.next()) {
			String[] livre = new String[5];
			livre[0] = rset.getString("id");
			livre[1] = rset.getString("isbn10");
			livre[2] = rset.getString("isbn13");
			livre[3] = rset.getString("titre");
			livre[4] = rset.getString("auteur");

			livres.add(livre);
		}
		rset.close();
		stmt.close();

		return livres;
	}

	/**
	 * Récupération de la liste des livres ayant un titre donné.
	 * 
	 * @param titre
	 *            : titre du livre à rechercher.
	 * @return un <code>ArrayList</code> contenant autant de tableaux de String
	 *         (5 chaînes de caractères) que de livres dans la base.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static ArrayList<String[]> listeLivres(String titre)
			throws SQLException {
		//
		// A COMPLETER
		// pourquoiiiiiiiiiiiii fdsgsdhdshsgsd
		ArrayList<String[]> listeLivres = new ArrayList<String[]>();

		Statement stmt = Connexion.getConnection().createStatement();
		String query = "select * from livre where titre ilike '%" + titre.replace("'", "''")
				+ "%' order by titre";
		System.out.println(query);
		ResultSet rset = stmt.executeQuery(query);

		while (rset.next()) {
			String[] livre = new String[5];
			livre[0] = rset.getString("id");
			livre[1] = rset.getString("isbn10");
			livre[2] = rset.getString("isbn13");
			livre[3] = rset.getString("titre");
			livre[4] = rset.getString("auteur");

			listeLivres.add(livre);
		}
		rset.close();
		stmt.close();

		return listeLivres;

	}

	/**
	 * Modification des informations du livre donné (via son identifiant id) :
	 * les nouvelles valeurs (isbn10, isbn13, etc.) écrasent les anciennes.
	 * 
	 * @param idLivre
	 *            : id du livre à modifier.
	 * @param isbn10
	 *            : nouvelle valeur d'isbn10.
	 * @param isbn13
	 *            : nouvelle valeur d'isbn13.
	 * @param titre
	 *            : nouvelle valeur du titre.
	 * @param auteur
	 *            : nouvel auteur.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static void modifierLivre(String idLivre, String isbn10,
			String isbn13, String titre, String auteur) throws SQLException {
		//
		// A COMPLETER
		// fackkkkkkkkkkkkfdsfdsfsdfsd

		Statement stmt = Connexion.getConnection().createStatement();

		String query = "UPDATE livre" + " SET isbn10 = '" + isbn10
				+ "', isbn13 = '" + isbn13 + "', titre = '" + titre.replace("'", "''")
				+ "', auteur = '" + auteur.replace("'", "''") + "' WHERE id = " + idLivre + ";";
		stmt.executeUpdate(query);

		/*
		 * System.out.println(query);
		 * 
		 * ResultSet rset = stmt.executeQuery(query);
		 * 
		 * while (rset.next()) { String[] livre = new String[5]; livre[0] =
		 * rset.getString("id"); livre[1] = rset.getString("isbn10"); livre[2] =
		 * rset.getString("isbn13"); livre[3] = rset.getString("titre");
		 * livre[4] = rset.getString("auteur");
		 * 
		 * } rset.close();
		 */
		stmt.close();

	}

	/**
	 * Supprime un livre à partir de son n° d'identifiant.
	 * 
	 * @param idLivre
	 *            : id du livre à supprimer.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static void supprimerLivre(String idLivre) throws SQLException {

		Statement stmt = Connexion.getConnection().createStatement();
		
		String query = "delete from livre where id = " + idLivre;
		System.out.println(query);

		stmt.executeUpdate(query);

		stmt.close();

	}

	/**
	 * Récupère les informations (titre, auteur, etc.) d'un livre à partir de
	 * son n° d'identifiant.
	 * 
	 * @param idLivre
	 *            : id du livre dont on veut les informations.
	 * @return un tableau de <code>String</code> contenant les informations d'un
	 *         livre.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static String[] getLivre(String idLivre) throws SQLException {
		//
		// A COMPLETER
		//
		String[] livre = new String[5];
		Statement stmt = Connexion.getConnection().createStatement();

		String query = "select * from livre where id = " + idLivre;

		System.out.println(query);
		ResultSet rset = stmt.executeQuery(query);

		while (rset.next()) {
			livre[0] = rset.getString("id");
			livre[1] = rset.getString("isbn10");
			livre[2] = rset.getString("isbn13");
			livre[3] = rset.getString("titre");
			livre[4] = rset.getString("auteur");
		}

		rset.close();
		stmt.close();

		return livre;
	}

	/**
	 * Retourne le nombre d'exemplaire d'un livre à partir de son numéro
	 * d'identifiant.
	 * 
	 * @param idLivre
	 *            : id du livre dont on veut connaître le nombre d'exemplaires.
	 * @return le nombre d'exemplaires
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static int nbExemplaires(String idLivre) throws SQLException {
		//
		// A COMPLETER
		//
		// int nbExemplaires = 0;
		int[] nb;
		nb = new int[5];

		Statement stmt = Connexion.getConnection().createStatement();

		String query = "select count(idExemplaire) as nb from exemplaire where idLivre="
				+ idLivre + ";";

		ResultSet rset = stmt.executeQuery(query);
		while (rset.next()) {

			nb[0] = rset.getInt("nb");

		}

		rset.close();
		stmt.close();

		return nb[0];
		// return 0;
	}

	/**
	 * Récupération de la liste des identifiants d'exemplaires d'un livre donné.
	 * 
	 * @param idLivre
	 *            : identifiant du livre dont on veut la liste des exemplaires.
	 * @return un <code>ArrayList</code> contenant les n° d'identifiant des
	 *         exemplaires
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static ArrayList<Integer> listeExemplaires(String idLivre)
			throws SQLException {
		//
		// A COMPLETER
		//
		ArrayList<Integer> listeEx = new ArrayList<Integer>();
		Statement stmt = Connexion.getConnection().createStatement();

		String query = "select idExemplaire from exemplaire where idLivre= "
				+ idLivre + ";";

		ResultSet rset = stmt.executeQuery(query);
		while (rset.next()) {
			listeEx.add(rset.getInt("idExemplaire"));
		}

		rset.close();
		stmt.close();

		return listeEx;
	}

	/**
	 * Ajout d'un exemplaire à un livre donné identifié par son id (idLivre).
	 * 
	 * @param id
	 *            "merge posgresql identifiant du livre dont on veut ajouter un
	 *            exemplaire.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static void ajouterExemplaire(String id) throws SQLException {
		//
		// A COMPLETER
		//
		Statement stmt = Connexion.getConnection().createStatement();
		String insert = "insert into exemplaire values(nextval('livre_id_seq'),'"
				+ id + "');";
		stmt.executeUpdate(insert);

		stmt.close();

	}

	/**
	 * Suppression d'un exemplaire donné identifié par son id.
	 * 
	 * @param idExemplaire
	 *            : identifiant du livre dont on veut supprimer un exemplaire.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static void supprimerExemplaire(String idExemplaire)
			throws SQLException {
		//
		// A COMPLETER
		//
		Statement stmt = Connexion.getConnection().createStatement();

		String query = "delete from emprunt where idexemplaire = " + idExemplaire + " and dateretour is not null;";
		stmt.executeUpdate(query);
		
		String query1 = "delete from exemplaire where idexemplaire = " + idExemplaire +";";
		stmt.executeUpdate(query1);

		stmt.close();
		}

	/**
	 * Détermine si un exemplaire est actuellement emprunté.
	 * 
	 * @param idExemplaire
	 * @return <code>true</code> si l'exemplaire est emprunté,
	 *         <code>false</code> sinon
	 * @throws344 SQLException en cas d'erreur de connexion à la base.merge
	 *            posgresql
	 */
	public static Boolean estEmprunte(int idExemplaire) throws SQLException {

		boolean indisponible = false;
		Statement stmt = Connexion.getConnection().createStatement();

		String query = "select idExemplaire from emprunt where dateRetour is NULL and idExemplaire ="
				+ idExemplaire + ";";
		

		ResultSet rset = stmt.executeQuery(query);
		while (rset.next()) {
					
			indisponible = true;
		}

		rset.close();
		stmt.close();

		return indisponible;
	}

	/**
	 * Détermine si un exemplaire est actuellement emprunté.
	 * 
	 * @param idExemplaire
	 *            : id de l'exemplaire.
	 * @return "true" si l'exemplaire est emprunté, "false" sinon.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static Boolean aEteEmprunte(int idExemplaire) throws SQLException {

		boolean aEteEmprunte = false;
		Statement stmt = Connexion.getConnection().createStatement();

		String query = "select idExemplaire from emprunt where dateRetour is not NULL and idExemplaire ="
				+ idExemplaire + ";";
		

		ResultSet rset = stmt.executeQuery(query);
		while (rset.next()) {
					
			aEteEmprunte = true;
		}

		rset.close();
		stmt.close();

		return aEteEmprunte;
	}
	

	/**
	 * Récupération de la liste de titre des livres à partir du début du titre.
	 * 
	 * @param debutTitreLivremerge
	 *            posgresql : un <code>String</code> correspond au début du
	 *            titre du livre
	 * @return Un <code>ArrayList<String></code> contenant autant de <String>
	 *         que de livres potentiels.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static ArrayList<String> debutLivre(String debutTitreLivre)
			throws SQLException {
		
		ArrayList<String> listeLivres = new ArrayList<String>();

		Statement stmt = Connexion.getConnection().createStatement();
		String query = "select titre from livre where titre ilike '" + debutTitreLivre.replace("'", "''")
				+ "%' order by titre";
		System.out.println(query);
		ResultSet rset = stmt.executeQuery(query);

		while (rset.next()) {
			
			String livre = rset.getString("titre");
			
			listeLivres.add(livre);
		}
		rset.close();
		stmt.close();

		return listeLivres;
	}

	/**
	 * Référencement d'un nouveau livre dans la base de données.
	 * 
	 * @param isbn10
	 * @param isbn13
	 * @param titre
	 * @param auteur
	 * @return l'identifiant (id) du livre créé.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static int creerLivre(String isbn10, String isbn13, String titre,
			String auteur) throws SQLException {	
				
		Statement stmt = Connexion.getConnection().createStatement();
		int id = 0;
		if (isbn10.matches("")||isbn13.matches("")||titre.matches("") || auteur.matches("")) {
			throw new SQLException();
		}
		
		else{
		String insert = "insert into livre values(nextval('livre_id_seq'),'"
				+ isbn10 + "','" + isbn13 + "','" + titre.replace("'", "''") + "','" + auteur.replace("'", "''") 
				+ "')";
		stmt.executeUpdate(insert);

		String query = "select currval('livre_id_seq') as valeur_courante_id_livre";
		ResultSet rset = stmt.executeQuery(query);
		rset.next();
		id = rset.getInt("valeur_courante_id_livre");
		rset.close();
		stmt.close();
		}
		return id;
	}
}
