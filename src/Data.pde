public static class Data {
  public static int fps = 144;
  public static float moveconst = 5;  // Moltiplicatore di velocità delle particelle
  public static float forcemult = 2;  // Moltiplicatore di forza di gravità
  public static float gconst = 6.67428;
  public static float gsizemult = 0.5;  // Moltiplicatori di grandezza
  public static float psizemult = 1;
  public static boolean bounded = true;  // Muri anelastici sul bordo
  public static float frictionmult = 1;  // Sempre >= 1
  public static float maxdist = 400;  // Limitatore di (raggio^2)
  public static float traildecay = 1;  // Persistenza delle scie
  public static boolean trails = true;  // Esistenza delle scie
  public static int mousemass = -1;  // Forza attrattiva del mouse
  public static float defaultmass = 8;  
  public static float deltamass = 0.2;  // Cambiamento di massa delle particelle piazzate per scorrimento di rotella del mouse
  public static boolean coinfluence = false;  // Attrattività tra particelle
  public static int mode = 0;
  public static int modes = 3;
  public static String[] modenames = {"Particle", "Center of gravity", "Particle Bulk"};
  public static boolean tooltip = false;
  public static int quantity = 10;
  public static float spread = 10;
  public static float spreadconst = 0.854;
}
