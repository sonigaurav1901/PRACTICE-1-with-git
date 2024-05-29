public class wrapperClassOfQuickBookData{
	public cls_eventNotifications[] eventNotifications;
	public class cls_eventNotifications {
		public String realmId;	//4620816365226018760
		public cls_dataChangeEvent dataChangeEvent;
	}
	public class cls_dataChangeEvent {
		public cls_entities[] entities;
	}
	public class cls_entities {
		public String name;	//Account
		public String id;	//96
		public String operation;	//Create
		public String lastUpdated;	//2022-09-01T14:20:54.000Z
	}
	public static wrapperClassOfQuickBookData parse(String json){
		return (wrapperClassOfQuickBookData) System.JSON.deserialize(json, wrapperClassOfQuickBookData.class);
	}
}