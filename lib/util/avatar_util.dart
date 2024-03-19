String avatarImageUrl(String uid) {
  return "https://firebasestorage.googleapis.com/v0/b/tik-tok-alkain77.appspot.com/o/avatars%2F$uid?alt=media&time=${DateTime.now().toString()}";
}
