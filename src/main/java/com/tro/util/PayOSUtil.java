package com.tro.util;

import vn.payos.PayOS;

public class PayOSUtil {

    private static final String CLIENT_ID = "fb35a724-6d02-490e-ac9b-a63a3f2758aa";
    private static final String API_KEY = "04d80326-f863-4462-af32-79d878cc7491";
    private static final String CHECKSUM_KEY = "5ba537719fdca2b9da2a560acebf3fbd1eeb337089c557e8168977f020bec7f4";

    private static PayOS payOS;

    public static PayOS getPayOS() {
        if (payOS == null) {
            payOS = new PayOS(CLIENT_ID, API_KEY, CHECKSUM_KEY);
        }
        return payOS;
    }
}
