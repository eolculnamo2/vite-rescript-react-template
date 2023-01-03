// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as Caml_module from "rescript/lib/es6/caml_module.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";

function createFolder(newId) {
  return {
          id: newId,
          name: "New folder",
          folders: [],
          files: []
        };
}

function findFolderById(targetFolderId, rootFolder) {
  if (rootFolder.id === targetFolderId) {
    return rootFolder;
  } else if (rootFolder.folders.length === 0) {
    return ;
  } else {
    return Belt_Option.getWithDefault(Caml_option.undefined_to_opt(Belt_Array.map(rootFolder.folders, (function (f) {
                            return findFolderById(targetFolderId, f);
                          })).find(Belt_Option.isSome)), undefined);
  }
}

function addFolder(newId, currentFolderId, rootFolder) {
  console.log("??");
  var folder = findFolderById(currentFolderId, rootFolder);
  Belt_Option.map(folder, (function (f) {
          f.folders.push(createFolder(newId));
          return f;
        }));
  return rootFolder;
}

var Folder = Caml_module.init_mod([
      "Folders.res",
      46,
      4
    ], {
      TAG: /* Module */0,
      _0: [
        [
          /* Function */0,
          "make"
        ],
        [
          /* Function */0,
          "makeProps"
        ]
      ]
    });

function Folders$Folder(Props) {
  var folder = Props.folder;
  var selectFolder = Props.selectFolder;
  return React.createElement("div", {
              onClick: (function (param) {
                  Curry._1(selectFolder, folder.id);
                })
            }, folder.name, Belt_Array.map(folder.folders, (function (f) {
                    return React.createElement(Folder.make, Curry._4(Folder.makeProps, f, selectFolder, String(f.id), undefined));
                  })));
}

Caml_module.update_mod({
      TAG: /* Module */0,
      _0: [
        [
          /* Function */0,
          "make"
        ],
        [
          /* Function */0,
          "makeProps"
        ]
      ]
    }, Folder, {
      make: Folders$Folder,
      makeProps: (function (prim0, prim1, prim2, prim3) {
          var tmp = {
            folder: prim0,
            selectFolder: prim1
          };
          if (prim2 !== undefined) {
            tmp.key = prim2;
          }
          return tmp;
        })
    });

export {
  createFolder ,
  findFolderById ,
  addFolder ,
  Folder ,
}
/* Folder Not a pure module */
