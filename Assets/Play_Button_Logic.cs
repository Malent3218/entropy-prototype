using UnityEngine;
using System.Collections;

public class Play_Button_Logic : MonoBehaviour {
	
	private Camera cam;
	
	[SerializeField]
	public GameObject leapController;
	[SerializeField]
	public GameObject playButton;
	[SerializeField]
	public GameObject lsButton;
	[SerializeField]
	public GameObject shopButton;
	[SerializeField]
	public GameObject settingsButton;
	[SerializeField]
	public GameObject challengeButton;
	
	bool gestureActive;
	
	// Use this for initialization
	void Start ()
	{
		cam = Camera.main;
		gestureActive = false;
	}
	
	// Update is called once per frame
	void Update ()
	{
		/*if (leapController.GetComponent<LeapController>().startTouch)
		{
			Vector3 screenPos = leapController.GetComponent<LeapController>().GUIPos;
			Ray ray = cam.ScreenPointToRay(screenPos);
			RaycastHit hitInfo;
			Physics.Raycast(ray, out hitInfo);
			if (hitInfo.collider == playButton.collider)
			{
				Play();
			}
		}*/
		if (!gestureActive)
		{
			float angle = leapController.GetComponent<LeapController>().PalmAngle;
			if (angle >= -18.0f && angle <= 18.0f)
			{
				playButton.transform.localScale = new Vector3(2.66f, 1.0f, 2.0f);
				if (leapController.GetComponent<LeapController>().GestureUp)
				{
					Play();
					gestureActive = true;
				}
			}
			else
			{
				playButton.transform.localScale = new Vector3(2.0f, 1.0f, 1.5f);
			}
			if (angle > 18.0f && angle <= 54.0f)
			{
				shopButton.transform.localScale = new Vector3(2.66f, 1.0f, 2.0f);
			}
			else
			{
				shopButton.transform.localScale = new Vector3(2.0f, 1.0f, 1.5f);
			}
			if (angle >= -54.0f && angle < -18.0f)
			{
				lsButton.transform.localScale = new Vector3(2.66f, 1.0f, 2.0f);
			}
			else
			{
				lsButton.transform.localScale = new Vector3(2.0f, 1.0f, 1.5f);
			}
			if (angle >= -90.0f && angle < -54.0f)
			{
				challengeButton.transform.localScale = new Vector3(2.66f, 1.0f, 2.0f);
			}
			else
			{
				challengeButton.transform.localScale = new Vector3(2.0f, 1.0f, 1.5f);
			}
			if (angle > 54.0f && angle <= 90.0f)
			{
				settingsButton.transform.localScale = new Vector3(2.66f, 1.0f, 2.0f);
			}
			else
			{
				settingsButton.transform.localScale = new Vector3(2.0f, 1.0f, 1.5f);
			}
		}
	}
	
	void Play()
	{
		/*AsyncOperation async = Application.LoadLevelAsync("Demo");
        Debug.Log("Loading level");
        yield return async;
        Debug.Log("Loading complete");
		*/Application.LoadLevel("Demo");
	}
}
