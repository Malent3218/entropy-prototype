using UnityEngine;
using System.Collections;

public class BackgroundController : MonoBehaviour {
	
	private Camera cam;
	[SerializeField]
	public Transform transform;
	
	// Use this for initialization
	void Start () {
		cam = Camera.main;
	}
	
	// Update is called once per frame
	void Update () {
		transform.position = new Vector3(cam.transform.position.x, transform.position.y, transform.position.z);
	}
}
