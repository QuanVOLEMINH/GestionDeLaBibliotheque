package biblio;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Composant logiciel assurant la gestion des emprunts d'exemplaires de livre
 * par les usagers.
 */
public class ComposantBDEmprunt {

	/**
	 * Récupération de la liste complète des emprunts en fonction de leur
	 * statut.
	 * 
	 * @return un <code>ArrayList</code> contenant autant de tableaux de String
	 *         (5 chaînes de caractères) que d'emprunts dans la base.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static ArrayList<String[]> listeEmprunts(String statut)
			throws SQLException {
		//
		// METHODE NON UTILISEE : INUTILE DE COMPLETER
		//
		return new ArrayList<String[]>();
	}

	/**
	 * Récupération de la liste complète des emprunts en cours.
	 * 
	 * @return un <code>ArrayList</code> contenant autant de tableaux de String
	 *         (5 chaînes de caractères) que d'emprunts dans la base.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static ArrayList<String[]> listeEmpruntsEnCours()
			throws SQLException {

		ArrayList<String[]> listeEmpruntsEnCours = new ArrayList<String[]>();

		Statement stmt = Connexion.getConnection().createStatement();
		String query = "SELECT idExemplaire,idUsager,dateEmprunt FROM emprunt WHERE dateRetour IS NULL order by dateEmprunt; ";
		System.out.println(query);
		ResultSet rset = stmt.executeQuery(query);

		while (rset.next()) {
			String[] empruntEnCours = new String[3];
			empruntEnCours[0] = rset.getString("idUsager");
			empruntEnCours[1] = rset.getString("idExemplaire");
			empruntEnCours[2] = rset.getString("dateEmprunt");

			listeEmpruntsEnCours.add(empruntEnCours);
		}
		rset.close();
		stmt.close();

		return listeEmpruntsEnCours;
	}

	/**
	 * Récupération de la liste complète des emprunts passés.
	 * 
	 * @return un <code>ArrayList</code> contenant autant de tableaux de String
	 *         (5 chaînes de caractères) que d'emprunts dans la base.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static ArrayList<String[]> listeEmpruntsHistorique()
			throws SQLException {

		ArrayList<String[]> historique = new ArrayList<String[]>();

		Statement stmt = Connexion.getConnection().createStatement();
		String query = "SELECT * FROM emprunt WHERE dateRetour IS NOT NULL order by dateEmprunt;";
		System.out.println(query);
		ResultSet rset = stmt.executeQuery(query);

		while (rset.next()) {
			String[] empruntFini = new String[4];
			//changer depend file jsp 				
			empruntFini[0] = rset.getString("idUsager");
			empruntFini[1] = rset.getString("idExemplaire");
			
			empruntFini[2] = rset.getString("dateEmprunt");
			empruntFini[3] = rset.getString("dateRetour");

			historique.add(empruntFini);
		}
		rset.close();
		stmt.close();

		return historique;
	}

	/**
	 * Emprunter un exemplaire à partir du n° d'usager et du n° d'exemplaire.
	 * 
	 * @param idUsager
	 *            : id de l'usager.
	 * @param idExemplaire
	 *            id de l'exemplaire emprunté.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static void emprunter(String idUsager, String idExemplaire)
			throws SQLException {

		Statement stmt = Connexion.getConnection().createStatement();
		if (!ComposantBDLivre.estEmprunte(Integer.valueOf(idExemplaire))) {
			String query = "INSERT INTO EMPRUNT VALUES(" + idExemplaire + ","
					+ idUsager + ", current_date, null)";
			System.out.println(query);
			stmt.executeUpdate(query);
		} else
			throw new SQLException();

		stmt.close();

	}

	/**
	 * Rendre un exemplaire à partir du n° d'exemplaire.
	 * 
	 * @param idExemplaire
	 *            id de l'exemplaire à rendre.
	 * @throws SQLException
	 *             en cas d'erreur de connexion à la base.
	 */
	public static void rendre(String idExemplaire) throws SQLException {


		System.out.println(idExemplaire);
		Statement stmt = Connexion.getConnection().createStatement();
		if (ComposantBDLivre.estEmprunte(Integer.valueOf(idExemplaire))) 
		{
			String query = "UPDATE emprunt SET dateRetour = current_date WHERE idExemplaire = "
					+ idExemplaire + ";";
			stmt.executeUpdate(query);
		}
		else throw new SQLException();

		stmt.close();
	}
}
