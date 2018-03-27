using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class camTrigger : MonoBehaviour {

	public Material[] materials;

	public Transform device;

	//bool for checking if the device is not in the same direction as it was
public	bool wasInfront;
	//bool for knowing that on the next change of state, what to set the stencil test
public	bool inOtherWorld;
	//This bool is on while device colliding, done so we ensure the shaders are being updated before render frames
	//Avoids flickering
//	bool isColliding;


	// Use this for initialization
	void Start () {
		SetMaterial (false);
	}

	void SetMaterial(bool fullRender)
	{
		var stencilTest = fullRender ? CompareFunction.NotEqual : CompareFunction.Equal;
		foreach (var mat in materials) 
		{
			mat.SetInt ("_StencilTest", (int)stencilTest);
		}
	}

	bool GetIsInfront()
	{  
		Vector3 pos = transform.InverseTransformPoint (device.position);
		return pos.z >= 0 ? true: false;
	}


	void OnTriggerEnter(Collider other)
	{
		
		
		if (other.transform != device)
			return;
		wasInfront = GetIsInfront ();

	}

	void OnTriggerStay(Collider other)
	{
		if (other.transform != device)
			return;
		bool isInFront = GetIsInfront ();
		if ((isInFront && !wasInfront) || (wasInfront && !isInFront)) 
		{
			inOtherWorld = !inOtherWorld;
			SetMaterial (inOtherWorld);
		}
		wasInfront = isInFront;
	}

	void OnDestroy()
	{
		SetMaterial (true);

	}


	// Update is called once per frame
	void Update () 
	{

	}
}
