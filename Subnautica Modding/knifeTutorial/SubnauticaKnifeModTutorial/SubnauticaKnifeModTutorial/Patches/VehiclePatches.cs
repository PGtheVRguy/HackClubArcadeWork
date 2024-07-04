using HarmonyLib;

namespace SubnauticaKnifeModTutorial.Patches
{
    // TODO Review this file and update to your own requirements, or remove it altogether if not required

    /// <summary>
    /// Sample Harmony Patch class. Suggestion is to use one file per patched class
    /// though you can include multiple patch classes in one file.
    /// Below is included as an example, and should be replaced by classes and methods
    /// for your mod.
    /// </summary>
    [HarmonyPatch(typeof(Vehicle))]
    internal class VehiclePatches
    {
        /// <summary>
        /// Patches the Player Awake method with prefix code.
        /// </summary>
        /// <param name="__instance"></param>
        [HarmonyPatch(nameof(Vehicle.Awake))]
        [HarmonyPrefix]
        public static bool Awake_Prefix(Vehicle __instance)
        {
            SubnauticaKnifeModTutorialPlugin.Log.LogInfo("In PlayerTool Awake method Prefix.");
            if(__instance.GetType() == typeof(SeaMoth))
            {
                SeaMoth seamoth = __instance as SeaMoth;
                seamoth.moveOnLand = true;
                //seamoth.stabilizeRoll = false;
                seamoth.SendMessage("TEST");
                seamoth.verticalForce = 30f;
                //seamoth.onGroundForceMultiplier = 20f;
            }
            return true;
        }
        /*
        /// <summary>
        /// Patches the Player Awake method with postfix code.
        /// </summary>
        /// <param name="__instance"></param>
        [HarmonyPatch(nameof(Player.Awake))]
        [HarmonyPostfix]
        public static void Awake_Postfix(Player __instance)
        {
            SubnauticaKnifeModTutorialPlugin.Log.LogInfo("In Player Awake method Postfix.");
        }*/
    }
}