package io.krumbs.sdk.starter;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.content.Context;

import java.util.LinkedList;
import java.util.List;
import android.provider.Settings.Secure;

public class DeviceUtils {

    /**
     * Returns the user name of primary google account.
     *
     * @return
     */
    public static String getUsername(Context context) {
        AccountManager manager = AccountManager.get(context);
        Account[] accounts = manager.getAccounts();//manager.getAccountsByType("com.google");
        List<String> possibleEmails = new LinkedList<String>();
        String retVal = null;
        for (Account account : accounts) {
            // TODO: Check possibleEmail against an email regex or treat
            // account.name as an email address only for certain account.type
            // values.
            if(account.type.equals("com.google")) {
                possibleEmails.add(account.name);
            }
        }

        if (!possibleEmails.isEmpty() && possibleEmails.get(0) != null) {
            String email = possibleEmails.get(0);
            String[] parts = email.split("@");
            if (parts.length > 0 && parts[0] != null)
                retVal = parts[0];
        }

        if(retVal == null)
        {
            // Fetch Device ID
            String android_id = Secure.getString(context.getContentResolver(), Secure.ANDROID_ID);
            retVal = android_id;
        }
        return retVal;
    }

    /**
     * Returns the user name of primary google account.
     *
     * @return
     */
    public static String getPrimaryUserID(Context context) {
        AccountManager manager = AccountManager.get(context);
        Account[] accounts = manager.getAccountsByType("com.google");
        List<String> possibleEmails = new LinkedList<String>();

        for (Account account : accounts) {
            // TODO: Check possibleEmail against an email regex or treat
            // account.name as an email address only for certain account.type
            // values.
            possibleEmails.add(account.name);
        }

        if (!possibleEmails.isEmpty() && possibleEmails.get(0) != null) {
            return possibleEmails.get(0);
        } else
            return null;
    }


}
