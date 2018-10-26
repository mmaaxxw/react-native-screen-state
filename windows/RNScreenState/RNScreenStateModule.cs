using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Screen.State.RNScreenState
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNScreenStateModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNScreenStateModule"/>.
        /// </summary>
        internal RNScreenStateModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNScreenState";
            }
        }
    }
}
