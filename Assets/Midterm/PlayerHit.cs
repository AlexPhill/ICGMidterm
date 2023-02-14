using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHit : MonoBehaviour
{
    public Material[] materialList; //list of materials.

    Renderer rend;
    // Start is called before the first frame update
    void Start()
    {
        //getting the mesh renderer when the program starts
        rend = GetComponent<Renderer>();
        rend.enabled = true;
        rend.sharedMaterial = materialList[0];
    }

    // Update is called once per frame
    void Update()
    {
        //When The user presses this button, the material will change
        if (Input.GetKey(KeyCode.Alpha0))
        {
            rend.sharedMaterial = materialList[0];
        }
        else if (Input.GetKey(KeyCode.Alpha1))
        {
            rend.sharedMaterial = materialList[1];
        }
    }
}
