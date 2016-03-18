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

#import "NSString+SBJSON.h"
#import "SBJsonParser.h"

@implementation NSString (NSString_SBJSON)

- (id)JSONFragmentValue
{
    SBJsonParser *jsonParser = [SBJsonParser new];    
    id repr = [jsonParser fragmentWithString:self];    
    if (!repr)
        PLog(@"-JSONFragmentValue failed. Error trace is: %@", [jsonParser errorTrace]);
    return repr;
}

- (id)JSONValue
{
    SBJsonParser *jsonParser = [SBJsonParser new];
    id repr = [jsonParser objectWithString:self];
    if (!repr)
        PLog(@"json解析出错. Error trace is: %@", [jsonParser errorTrace]);
    return repr;
}

@end
