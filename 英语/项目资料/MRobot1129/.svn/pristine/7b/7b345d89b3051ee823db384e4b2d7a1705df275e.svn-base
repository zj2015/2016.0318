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

#import "NSObject+SBJSON.h"
#import "SBJsonWriter.h"

@implementation NSObject (NSObject_SBJSON)

- (NSString *)JSONFragment {
    SBJsonWriter *jsonWriter = [SBJsonWriter new];
    NSString *json = [jsonWriter stringWithFragment:self];    
    if (!json)
        PLog(@"-JSONFragment failed. Error trace is: %@", [jsonWriter errorTrace]);
    return json;
}

- (NSString *)JSONRepresentation {
    SBJsonWriter *jsonWriter = [SBJsonWriter new];    
    NSString *json = [jsonWriter stringWithObject:self];
    if (!json)
        PLog(@"-JSONRepresentation failed. Error trace is: %@", [jsonWriter errorTrace]);
    return json;
}

@end
