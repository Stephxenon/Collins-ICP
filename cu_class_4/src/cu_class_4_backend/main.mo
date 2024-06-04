import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Option "mo:base/Option";
import List "mo:base/List";
import Iter "mo:base/Iter";

actor BookmarksManager {

  type Bookmark = {
    url : Text;
    title : Text;
  };

  var bookmarks = HashMap.HashMap<Text, Bookmark>(100, Text.equal, Text.hash);

  public func addBookmark(title : Text, url : Text) {
    let newBookmark = { title = title; url = url };
    bookmarks.put(url, newBookmark);
  };

  public func removeBookmark(url : Text) {
    bookmarks.delete(url);
  };

  public func getBookmark(url : Text) : async ?Bookmark {
    bookmarks.get(url);
  };

  public func updateBookmarkTitle(url : Text, newTitle : Text) : async ?Bookmark {
    switch (bookmarks.get(url)) {
      case (null) {
        null;
      };
      case (?bookmark) {
        let updatedBookmark = { title = newTitle; url = bookmark.url };
        bookmarks.put(url, updatedBookmark);
        ?updatedBookmark;
      };
    };
  };

  public func getAllBookmarks() : async [Bookmark] {
    Iter.toArray<Bookmark>(bookmarks.vals());
  };
};
