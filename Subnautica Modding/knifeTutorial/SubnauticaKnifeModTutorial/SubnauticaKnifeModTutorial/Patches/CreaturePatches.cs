using HarmonyLib;
using UnityEngine;
using System.Collections.Generic;
using Nautilus;
using Nautilus.Handlers;

namespace SubnauticaKnifeModTutorial.Patches
{
    // TODO Review this file and update to your own requirements, or remove it altogether if not required

    /// <summary>
    /// Sample Harmony Patch class. Suggestion is to use one file per patched class
    /// though you can include multiple patch classes in one file.
    /// Below is included as an example, and should be replaced by classes and methods
    /// for your mod.
    /// </summary>
    [HarmonyPatch(typeof(Creature))]
    internal class CreaturePatches
    {



        /// <summary>
        /// Patches the Player Awake method with prefix code.
        /// </summary>
        /// <param name="__instance"></param>
        [HarmonyPatch(nameof(Creature.Start))]
        [HarmonyPrefix]
        public static void Start_Prefix(Creature __instance)
        {
            GameObject __creature = __instance.gameObject;

            TechType __techType = CraftData.GetTechType(__creature);

            float size = 1f;
            size = Random.Range(0.5f, 2f);
            __instance.transform.localScale = new Vector3(size, size, size);


            string classId = "GhostRayRed"; 
            Vector3 spawnPosition = new Vector3(0, 0, 0); 
            Quaternion rotation = Quaternion.identity; 

            SpawnInfo spawnInfo = new SpawnInfo(classId, spawnPosition, rotation);


            switch (__techType)
            {
                
            
            case TechType.Peeper:
                    
                    CoordinatedSpawnsHandler.RegisterCoordinatedSpawn(spawnInfo);

                    break;

            }
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