/*
  
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
   list of conditions and the following disclaimer.
 
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
   to endorse or promote products derived from this software without specific
   prior written permission.
 
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>


/**
 @brief Adds JSON generation to Foundation classes
 
 This is a category on NSObject that adds methods for returning JSON representations
 of standard objects to the objects themselves. This means you can call the
 -JSONRepresentation method on an NSArray object and it'll do what you want.
 */
@interface NSObject (NSObject_SBJSON)

/**
 @brief Returns a string containing the receiver encoded as a JSON fragment.
 
 This method is added as a category on NSObject but is only actually
 supported for the following objects:
 @li NSDictionary
 @li NSArray
 @li NSString
 @li NSNumber (also used for booleans)
 @li NSNull 
 
 @deprecated Given we bill ourselves as a "strict" JSON library, this method should be removed.
 */
- (NSString *)JSONFragment;

/**
 @brief Returns a string containing the receiver encoded in JSON.

 This method is added as a category on NSObject but is only actually
 supported for the following objects:
 @li NSDictionary
 @li NSArray
 */
- (NSString *)JSONRepresentation;

@end

