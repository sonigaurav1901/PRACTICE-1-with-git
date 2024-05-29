public class JSON2Apex {

	public class Geometry {
		public String type;
		public List<Double> coordinates;
	}

	public class Properties_V {
		public String name;
		public String label;
		public String category;
		public String type;
		public Double score;
		public String region;
		public String county;
		public String macroregion;
		public String town;
		public String country;
		public String country_code;
		public Features features;
	}

	public class Properties_W {
		public String name;
		public String label;
		public String category;
		public String type;
		public Double score;
		public String region;
		public String county;
		public String macroregion;
		public String city;
		public String district;
		public String country;
		public String country_code;
		public String postcode;
		public Features features;
	}

	public class Cross_country_modes {
	}

	public String type;
	public List<Features_Z> features;

	public class Properties_Z {
		public String name;
		public String label;
		public String category;
		public String type;
		public Double score;
		public String region;
		public String macroregion;
		public String country;
		public String country_code;
		public Features features;
	}

	public class Properties_X {
		public String name;
		public String label;
		public String category;
		public String type;
		public Double score;
		public String region;
		public String county;
		public String macroregion;
		public String town;
		public String country;
		public String country_code;
		public String postcode;
		public Features features;
	}

	public class Properties_Y {
		public String name;
		public String label;
		public String category;
		public String type;
		public Double score;
		public String region;
		public String county;
		public String macroregion;
		public String country;
		public String country_code;
		public Features features;
	}

	public class Features {
		public Public_transport public_transport;
		public List<Cross_country_modes> cross_country_modes;
		public Boolean fares;
		public Boolean postcodes;
	}

	public class Properties {
		public String name;
		public String label;
		public String category;
		public String type;
		public Double score;
		public String region;
		public String county;
		public String macroregion;
		public String city;
		public String country;
		public String country_code;
		public String postcode;
		public Features features;
	}

	public class Features_Z {
		public String type;
		public Geometry geometry;
		public Properties properties;
	}

	public class Public_transport {
		public String date_start;
		public String date_end;
	}

	
	public static JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}
}